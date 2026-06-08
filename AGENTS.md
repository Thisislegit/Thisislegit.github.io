# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Overview

This is a Jekyll-based academic website built on GitHub Pages using the academicpages template (forked from Minimal Mistakes Jekyll Theme). It serves as a personal academic portfolio for Xu Chen, a Ph.D. student at University of Electronic Science and Technology of China.

## Development Commands

### Local Development
```bash
# Install Ruby dependencies
bundle install

# Clean up directory (if needed)
bundle clean

# Serve locally with live reload
bundle exec jekyll serve
```

The local server will automatically rebuild and refresh pages on change at `localhost:4000`.

### Build Assets
```bash
# Build minified JavaScript
npm run build:js

# Watch for JS changes and rebuild
npm run watch:js
```

## Site Architecture

### Jekyll Structure
- `_config.yml` - Main site configuration
- `_config.dev.yml` - Development-specific overrides
- `_layouts/` - Page templates (default, single, archive, talk, etc.)
- `_includes/` - Reusable components and partials
- `_sass/` - SCSS stylesheets
- `_data/` - Site data files (navigation, UI text, comments)

### Content Collections
The site uses Jekyll collections for organized content:
- `_pages/` - Static pages (about, CV, publications, etc.)
- `_posts/` - Blog posts
- `_publications/` - Academic publications
- `_talks/` - Conference talks and presentations
- `_teaching/` - Teaching experience
- `_portfolio/` - Portfolio items

### Content Generation
The `markdown_generator/` folder contains Jupyter notebooks and Python scripts to generate markdown files from TSV data for publications and talks. This allows bulk import of structured academic content.

## Publication Update Gotchas

The homepage and the publications page do not currently share one generated data source.

- The site homepage is `_pages/about.md` because it has `permalink: /` and `layout: homepage`.
- The homepage publication list is hand-written inside `_pages/about.md` under `<section class="home-publications">`.
- The standalone publications page is `_pages/publications.md` with `permalink: /publications/`; it has a separate hand-written publication list.
- The `_publications/` collection files and `markdown_generator/publications.tsv` are not used by the visible publication pages right now because the `site.publications` loop in `_pages/publications.md` is commented out.

When adding a new paper that should appear on the public homepage, update `_pages/about.md`. If the paper should also appear on `/publications/`, update `_pages/publications.md` as well. Do not assume that adding a file under `_publications/` will make the paper visible.

If the browser is showing `https://thisislegit.github.io/`, it is the deployed GitHub Pages site and will not show local changes until they are committed, pushed, and deployed. Use `http://127.0.0.1:4000/` for local Jekyll preview.

For local builds on this machine, `/usr/bin/ruby` is Ruby 2.6 and cannot satisfy the current `Gemfile.lock` Bundler 2.7.1 requirement. Use the Homebrew Ruby toolchain:

```bash
/opt/homebrew/bin/bundle exec jekyll build
/opt/homebrew/bin/bundle exec jekyll serve --host 127.0.0.1 --port 4000 --no-watch
```

### Key Configuration
- Site owner: Xu Chen (Thisislegit.github.io)
- Theme: Modified Minimal Mistakes
- Analytics: Google Universal Analytics
- Collections have specific permalinks and layouts defined in `_config.yml`
- Author profile data configured in `_config.yml` under `author:`

### Dependencies
- Ruby gems managed via Gemfile (github-pages, jekyll-feed, jekyll-sitemap, hawkins)
- JavaScript dependencies managed via package.json for build tools
- Uses GitHub Pages compatible plugins only
