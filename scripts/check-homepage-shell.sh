#!/usr/bin/env bash
set -euo pipefail

bundle exec jekyll build >/tmp/homepage-shell-check.log

HOME_HTML="_site/index.html"
PUBS_HTML="_site/publications/index.html"

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
