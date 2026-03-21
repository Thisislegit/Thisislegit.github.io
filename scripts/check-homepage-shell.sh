#!/usr/bin/env bash
set -euo pipefail

bundle exec jekyll build >/tmp/homepage-shell-check.log

HOME_HTML="_site/index.html"
PUBS_HTML="_site/publications/index.html"

if rg -q '<div class="masthead">' "$HOME_HTML"; then
  echo "FAIL: homepage still renders masthead"
  exit 1
fi

if rg -q 'class="sidebar sticky"' "$HOME_HTML"; then
  echo "FAIL: homepage still renders sidebar author card"
  exit 1
fi

if rg -q 'class="page__title"' "$HOME_HTML"; then
  echo "FAIL: homepage still renders page title"
  exit 1
fi

if ! rg -q '<div class="masthead">' "$PUBS_HTML"; then
  echo "FAIL: publications page lost shared masthead"
  exit 1
fi

echo "PASS: homepage chrome isolated"
