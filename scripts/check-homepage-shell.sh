#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="$(mktemp -d -t homepage-shell-check.XXXXXX)"
BUILD_LOG="$(mktemp -t homepage-shell-check.XXXXXX)"
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
PUBS_HTML="$BUILD_DIR/publications/index.html"

has_class() {
  grep -Eq '<[^>]+class="[^"]*'"$1"'[^"]*"' "$2"
}

if has_class 'masthead' "$HOME_HTML"; then
  echo "FAIL: homepage still renders masthead"
  exit 1
fi

if has_class 'sidebar' "$HOME_HTML" && has_class 'sticky' "$HOME_HTML"; then
  echo "FAIL: homepage still renders sidebar author card"
  exit 1
fi

if has_class 'page__title' "$HOME_HTML"; then
  echo "FAIL: homepage still renders page title"
  exit 1
fi

if ! has_class 'masthead' "$PUBS_HTML"; then
  echo "FAIL: publications page lost shared masthead"
  exit 1
fi

echo "PASS: homepage chrome isolated"
