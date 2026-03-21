# Homepage Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the approved homepage redesign on `/` without changing the layout or behavior of other pages.

**Architecture:** Add a homepage-specific layout path so `/` can suppress the masthead, sidebar, and page title without rewriting the rest of the theme. Rewrite `_pages/about.md` into structured homepage sections, then layer homepage-scoped SCSS on top of the existing Jekyll pipeline so the design changes stay isolated to `/`.

**Tech Stack:** Jekyll, Liquid layouts, SCSS, GitHub Pages gem bundle, shell smoke checks, Playwright CLI for local visual verification

---

## Preflight

- Execute this plan in a dedicated git worktree before touching homepage files.
- Run `bundle install` once before Task 1 if `bundle exec jekyll build` fails with `bundler: command not found: jekyll`.
- No JavaScript changes are expected for this redesign.

## File Map

- Create: `scripts/check-homepage-shell.sh`
  Purpose: Build the site and assert homepage chrome is removed on `/` while a non-home page still keeps the theme masthead.

- Create: `scripts/check-homepage-content.sh`
  Purpose: Build the site and assert the new homepage sections and labels are present in generated HTML.

- Create: `_layouts/homepage.html`
  Purpose: Homepage-only layout that renders the approved single-column shell without the default page header or sidebar.

- Create: `_sass/_homepage.scss`
  Purpose: Homepage-only visual rules for spacing, typography, hero layout, research bullets, and compact publications.

- Modify: `_layouts/default.html`
  Purpose: Allow homepage rendering to suppress the masthead when the page opts out.

- Modify: `_pages/about.md`
  Purpose: Switch the homepage to the new layout and replace the current prose with the approved section structure.

- Modify: `assets/css/main.scss`
  Purpose: Import the homepage partial into the compiled stylesheet.

## Task 1: Isolate Homepage Chrome

**Files:**
- Create: `scripts/check-homepage-shell.sh`
- Create: `_layouts/homepage.html`
- Modify: `_layouts/default.html`
- Modify: `_pages/about.md`
- Test: `scripts/check-homepage-shell.sh`

- [ ] **Step 1: Write the failing homepage shell smoke check**

```bash
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
```

- [ ] **Step 2: Run the smoke check to verify it fails on the current homepage**

Run: `bash scripts/check-homepage-shell.sh`
Expected: FAIL because the current homepage still includes the masthead, sidebar, and page title.

- [ ] **Step 3: Implement the minimal homepage-only layout isolation**

Create `_layouts/homepage.html` as a simple page shell:

```liquid
---
layout: default
---

{% include base_path %}

<div id="main" class="home-page" role="main">
  <article class="page page--home">
    <div class="page__inner-wrap">
      <section class="page__content home-content" itemprop="text">
        {{ content }}
      </section>
    </div>
  </article>
</div>
```

Update `_layouts/default.html` to conditionally skip the masthead:

```liquid
{% unless page.hide_masthead %}
  {% include masthead.html %}
{% endunless %}
```

Update the homepage front matter in `_pages/about.md`:

```yaml
layout: homepage
author_profile: false
hide_masthead: true
```

- [ ] **Step 4: Re-run the build and smoke check**

Run: `bundle exec jekyll build && bash scripts/check-homepage-shell.sh`
Expected: PASS with the homepage missing chrome and `/publications/` still keeping the masthead.

- [ ] **Step 5: Commit**

```bash
git add scripts/check-homepage-shell.sh _layouts/homepage.html _layouts/default.html _pages/about.md
git commit -m "feat: isolate homepage layout from theme chrome"
```

## Task 2: Rewrite Homepage Content Into Approved Sections

**Files:**
- Create: `scripts/check-homepage-content.sh`
- Modify: `_pages/about.md`
- Test: `scripts/check-homepage-content.sh`

- [ ] **Step 1: Write the failing homepage content smoke check**

```bash
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
```

- [ ] **Step 2: Run the content smoke check to verify it fails**

Run: `bash scripts/check-homepage-content.sh`
Expected: FAIL because the current homepage content has not yet been rewritten into the new section structure.

- [ ] **Step 3: Rewrite `_pages/about.md` using semantic homepage sections**

Use HTML blocks inside the markdown file so the homepage structure is explicit and styleable:

```html
<section class="home-hero">
  <img class="home-hero__avatar" src="/images/xuchen_profile.jpg" alt="Xu Chen">
  <div class="home-hero__body">
    <h1 class="home-hero__name">Xu Chen</h1>
    <p class="home-hero__tagline">Ph.D. student at UESTC working on machine learning for data systems.</p>
    <p class="home-hero__links">
      <a href="mailto:XUCHEN.2019@outlook.com">Email</a>
      <a href="https://scholar.google.com/citations?user=i6heNjgAAAAJ&hl">Google Scholar</a>
      <a href="https://github.com/Thisislegit">GitHub</a>
    </p>
  </div>
</section>

<section class="home-bio">
  <h2>About</h2>
  <p>...</p>
</section>

<section class="home-research">
  <h2>Research Interests</h2>
  <p>...</p>
  <ul>
    <li>...</li>
    <li>...</li>
    <li>...</li>
  </ul>
</section>

<section class="home-publications">
  <h2>Publications</h2>
  <div class="publication-group">
    <h3>Recent Work</h3>
    <article class="publication">
      <p class="publication__title"><a href="...">Paper title</a></p>
      <p class="publication__meta"><strong>Xu Chen</strong>, Coauthor, <em>Venue</em>, 2025.</p>
    </article>
  </div>
  <div class="publication-group">
    <h3>Earlier Work</h3>
    <article class="publication">
      <p class="publication__title">Paper title</p>
      <p class="publication__meta">Author list, <em>Venue</em>, 2022.</p>
    </article>
  </div>
</section>
```

Content rules while rewriting:

- keep the biography to one tighter paragraph
- make the hero tagline newly written from existing facts
- keep `Recent Work` for 2023 and newer, `Earlier Work` for 2022 and older
- keep every publication on the homepage
- wrap every publication in `<article class="publication">`
- format each publication as title line + metadata line using `.publication__title` and `.publication__meta`

- [ ] **Step 4: Re-run the build and content smoke check**

Run: `bundle exec jekyll build && bash scripts/check-homepage-content.sh`
Expected: PASS with all homepage section markers present and the old `Selected Papers` label gone.

- [ ] **Step 5: Commit**

```bash
git add scripts/check-homepage-content.sh _pages/about.md
git commit -m "feat: rewrite homepage content into structured sections"
```

## Task 3: Add Homepage-Scoped Styles And Verify Visually

**Files:**
- Create: `_sass/_homepage.scss`
- Modify: `assets/css/main.scss`
- Test: `bundle exec jekyll build`, `bash scripts/check-homepage-shell.sh`, `bash scripts/check-homepage-content.sh`

- [ ] **Step 1: Capture a baseline local preview before the style pass**

Run:

```bash
bundle exec jekyll serve --host 127.0.0.1 --port 4000
```

Then open `/` in Playwright at desktop and mobile widths.
Expected: the structure is correct after Tasks 1 and 2, but the page still looks too close to the default theme.

- [ ] **Step 2: Implement homepage-only SCSS**

Create `_sass/_homepage.scss` with rules for:

```scss
.home-page {
  margin-top: 0;
  max-width: 100%;
  background: #fff;
}

.home-content {
  max-width: 42rem;
  margin: 0 auto;
  padding: 3rem 1.5rem 4rem;
}

.home-hero {
  display: grid;
  grid-template-columns: auto 1fr;
  gap: 1rem;
}

.home-publications .publication {
  padding: 0.9rem 0;
  border-top: 1px solid #ececec;
}

.publication__title,
.publication__meta {
  margin: 0;
}
```

Style goals:

- pure white background
- restrained serif/sans hierarchy
- no card treatment
- thin gray dividers only
- tighter publication rhythm
- responsive single column on mobile

- [ ] **Step 3: Import the new partial into `assets/css/main.scss`**

Add:

```scss
@import "homepage";
```

after the existing page/archive/sidebar imports so the homepage rules compile into `assets/css/main.css`.

- [ ] **Step 4: Rebuild and run the smoke checks**

Run: `bundle exec jekyll build && bash scripts/check-homepage-shell.sh && bash scripts/check-homepage-content.sh`
Expected: PASS for both smoke scripts and no SCSS compilation errors.

- [ ] **Step 5: Run desktop and mobile visual verification**

Check these states in the local preview:

- homepage shows a pure white background
- homepage is a narrow single column
- avatar, name, and inline links stay balanced at desktop width
- mobile layout collapses cleanly without horizontal overflow
- publication entries remain readable when titles wrap
- `/publications/` still keeps the original shared theme chrome

- [ ] **Step 6: Commit**

```bash
git add _sass/_homepage.scss assets/css/main.scss
git commit -m "feat: style homepage redesign"
```

## Task 4: Final Regression Sweep

**Files:**
- Modify: `_pages/about.md` or `_sass/_homepage.scss` only if the final preview reveals minor spacing issues
- Test: `bundle exec jekyll build`, smoke scripts, local preview

- [ ] **Step 1: Run the final build and both smoke scripts**

Run:

```bash
bundle exec jekyll build
bash scripts/check-homepage-shell.sh
bash scripts/check-homepage-content.sh
```

Expected: All commands pass.

- [ ] **Step 2: Verify one homepage view and one non-homepage view in the browser**

Review:

- `http://127.0.0.1:4000/`
- `http://127.0.0.1:4000/publications/`

Expected: homepage matches the approved design direction and non-homepage layout remains unchanged.

- [ ] **Step 3: If needed, apply only minor spacing or typography polish**

Allowed polish:

- adjust hero spacing
- tune publication row spacing
- refine heading margins

Do not expand scope beyond homepage visual polish.

- [ ] **Step 4: Re-run the build and smoke scripts if any polish changed files**

Run: `bundle exec jekyll build && bash scripts/check-homepage-shell.sh && bash scripts/check-homepage-content.sh`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add _pages/about.md _sass/_homepage.scss
git commit -m "chore: finalize homepage redesign polish"
```
