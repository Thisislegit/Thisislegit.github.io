#!/usr/bin/env bash
set -euo pipefail

bundle exec jekyll build >/tmp/homepage-content-check.log

HOME_HTML="_site/index.html"

rg -q 'class="home-hero"' "$HOME_HTML" || { echo "FAIL: missing hero section"; exit 1; }
rg -q 'class="home-bio"' "$HOME_HTML" || { echo "FAIL: missing bio section"; exit 1; }
rg -q 'class="home-research"' "$HOME_HTML" || { echo "FAIL: missing research section"; exit 1; }
rg -q 'class="home-publications"' "$HOME_HTML" || { echo "FAIL: missing publications section"; exit 1; }
rg -q '>Publications<' "$HOME_HTML" || { echo "FAIL: missing Publications heading"; exit 1; }
rg -q '>Recent Work<' "$HOME_HTML" || { echo "FAIL: missing Recent Work group"; exit 1; }
rg -q '>Earlier Work<' "$HOME_HTML" || { echo "FAIL: missing Earlier Work group"; exit 1; }

if rg -q '>Selected Papers<' "$HOME_HTML"; then
  echo "FAIL: old Selected Papers heading still present"
  exit 1
fi

PUB_COUNT="$(rg -o 'class=\"publication\"' "$HOME_HTML" | wc -l | tr -d ' ')"
if [ "$PUB_COUNT" -ne 12 ]; then
  echo "FAIL: expected 12 publication entries, found $PUB_COUNT"
  exit 1
fi

echo "PASS: homepage content sections rendered"
