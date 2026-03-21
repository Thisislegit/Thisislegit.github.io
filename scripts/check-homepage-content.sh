#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="$(mktemp -d -t homepage-content-check.XXXXXX)"
BUILD_LOG="$(mktemp -t homepage-content-check.XXXXXX)"
cleanup() {
  rm -rf "$BUILD_DIR"
}
trap cleanup EXIT

if ! bundle exec jekyll build --destination "$BUILD_DIR" >"$BUILD_LOG" 2>&1; then
  echo "FAIL: jekyll build failed; inspect $BUILD_LOG"
  exit 1
fi

rm -f "$BUILD_LOG"

HOME_HTML="$BUILD_DIR/index.html"

rg -q 'class="home-hero"' "$HOME_HTML" || { echo "FAIL: missing hero section"; exit 1; }
rg -q 'class="home-hero__avatar"' "$HOME_HTML" || { echo "FAIL: missing homepage avatar"; exit 1; }
if rg -q 'class="home-hero__avatar" src="/images/xuchen_profile.jpg"' "$HOME_HTML"; then
  echo "FAIL: homepage avatar still renders a root-relative image path"
  exit 1
fi
if ! rg -q 'class="home-hero__avatar" src="https?://[^"]*/images/xuchen_profile.jpg"' "$HOME_HTML"; then
  echo "FAIL: homepage avatar is not rendered with an absolute deployment-aware URL"
  exit 1
fi
rg -q 'class="home-bio"' "$HOME_HTML" || { echo "FAIL: missing bio section"; exit 1; }
rg -q 'class="home-research"' "$HOME_HTML" || { echo "FAIL: missing research section"; exit 1; }
rg -q 'class="home-publications"' "$HOME_HTML" || { echo "FAIL: missing publications section"; exit 1; }
rg -q '>Publications<' "$HOME_HTML" || { echo "FAIL: missing Publications heading"; exit 1; }

PUB_COUNT="$(rg -o 'class=\"publication\"' "$HOME_HTML" | wc -l | tr -d ' ')"
if [ "$PUB_COUNT" -ne 12 ]; then
  echo "FAIL: expected 12 publication entries, found $PUB_COUNT"
  exit 1
fi

TITLE_COUNT="$(rg -o 'class=\"publication__title\"' "$HOME_HTML" | wc -l | tr -d ' ')"
if [ "$TITLE_COUNT" -ne 12 ]; then
  echo "FAIL: expected 12 publication title lines, found $TITLE_COUNT"
  exit 1
fi

META_COUNT="$(rg -o 'class=\"publication__meta\"' "$HOME_HTML" | wc -l | tr -d ' ')"
if [ "$META_COUNT" -ne 12 ]; then
  echo "FAIL: expected 12 publication meta lines, found $META_COUNT"
  exit 1
fi

awk '
  /<div class="publication-group">/ { group++ }
  group == 1 && /<h3>Recent Work<\/h3>/ { recent_heading = 1 }
  group == 2 && /<h3>Earlier Work<\/h3>/ { earlier_heading = 1 }
  group == 1 && /<article class="publication">/ { recent_publications++ }
  group == 2 && /<article class="publication">/ { earlier_publications++ }
  END {
    if (group != 2) {
      printf "FAIL: expected 2 publication groups, found %d\n", group
      exit 1
    }
    if (!recent_heading) {
      print "FAIL: missing Recent Work publication group"
      exit 1
    }
    if (!earlier_heading) {
      print "FAIL: missing Earlier Work publication group"
      exit 1
    }
    if (recent_publications != 4) {
      printf "FAIL: expected 4 Recent Work publications, found %d\n", recent_publications
      exit 1
    }
    if (earlier_publications != 8) {
      printf "FAIL: expected 8 Earlier Work publications, found %d\n", earlier_publications
      exit 1
    }
  }
' "$HOME_HTML"

if rg -q '>Selected Papers<' "$HOME_HTML"; then
  echo "FAIL: old Selected Papers heading still present"
  exit 1
fi

echo "PASS: homepage content sections rendered"
