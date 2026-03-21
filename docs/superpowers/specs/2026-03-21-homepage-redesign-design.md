# Homepage Redesign Design

Date: 2026-03-21
Status: Approved in chat, ready for planning review

## Summary

Redesign the homepage `/` of Xu Chen's academic website into a simpler single-column page with a cleaner, more natural typographic tone. The redesign should move away from the default Minimal Mistakes page chrome and closer to the reading feel of a minimal academic homepage such as [zongheng.me](https://zongheng.me/), while still keeping a balanced amount of information on the page.

The homepage should keep the avatar, keep all publications on the homepage, and remove visual noise such as the top navigation bar, the sidebar author card, and the `About Me` page title. The visual direction is pure white, restrained, and text-first.

## Goals

- Redesign only the homepage `/`.
- Make the homepage feel simpler, cleaner, and more natural.
- Keep the avatar visible in the hero area.
- Show `Email`, `Google Scholar`, and `GitHub` directly under the name.
- Use a balanced information density: not too sparse, not too crowded.
- Keep all publications on the homepage in a more compact format.
- Improve readability by using a narrower reading column, clearer hierarchy, and lighter visual separation.

## Non-Goals

- Do not redesign or restructure `Publications`, `CV`, `Talks`, or other non-homepage pages.
- Do not add homepage links or navigation jumps to those pages.
- Do not perform a site-wide theme overhaul.
- Do not introduce new content sections outside the existing homepage scope.
- Do not add decorative backgrounds, cards, or heavy visual treatments.

## Current State

The current homepage is `_pages/about.md` rendered through the default `single` layout from the Minimal Mistakes-based theme. This produces three behaviors that conflict with the redesign goal:

1. A global masthead/navigation appears above the homepage.
2. The default author sidebar card appears beside the main content.
3. The page title `About Me` appears before the actual homepage content.

The homepage content itself is also too dense in its current form:

- the opening biography paragraph is longer than needed for a homepage intro
- `Research Interests` is written as two long explanation blocks
- the publications list is readable but visually heavy because each item occupies too much vertical space

## Target Experience

The homepage should read like a clean academic profile page:

- immediate entry into personal information without extra chrome
- a calm, centered reading column
- pure white background
- simple typography with a natural feel
- restrained section dividers instead of cards or colored panels
- compact but readable publication entries

The page should feel intentionally minimal, but not empty.

## Information Architecture

The homepage should use a single-column structure in this order:

1. Hero block
2. Short biography
3. Research interests
4. Publications

No other homepage sections are required for this redesign.

## Section Design

### 1. Hero Block

The hero block should replace the current combination of page title, masthead context, and sidebar author card.

Content:

- avatar
- name: `Xu Chen`
- one short descriptive sentence, newly written by tightening existing factual content from the current homepage rather than copied verbatim
- one inline links row containing `Email`, `Google Scholar`, and `GitHub`

Rules:

- the avatar remains visible
- the links should appear directly under the name/introduction line, not inside a button menu
- the block should feel lightweight and editorial rather than like a profile widget
- no CTA buttons
- no boxed card treatment

### 2. Short Biography

Replace the current long opening paragraph with a tighter single paragraph.

The new paragraph should preserve the existing factual content:

- Xu Chen is a Ph.D. student at the School of Computer Science and Engineering, UESTC
- advisors: Kai Zheng and Han Su
- dual Bachelor's degrees from UESTC and the University of Glasgow

Guidelines:

- shorten the prose
- improve flow and readability
- keep the tone academic and straightforward
- avoid sounding promotional

### 3. Research Interests

This section should be reformatted from long-form prose into:

- one short summary sentence introducing the research agenda
- followed by 2 to 3 short lines or bullets

The content should center on:

- machine learning for query optimization
- LLM/database agents
- reinforcement learning for practical database systems

Guidelines:

- keep each point short
- optimize for scanning, not paragraph reading
- preserve the substance of the current text without repeating full explanations

### 4. Publications

This section should keep all publications on the homepage.

Structure:

- section heading: `Publications`
- keep light grouping by `Recent Work` and `Earlier Work`
- preserve the current homepage grouping boundary: `Recent Work` contains 2023 and newer entries, and `Earlier Work` contains 2022 and older entries
- within each group, list items in reverse chronological order

Each publication entry should use a compact two-line rhythm:

- line 1: paper title, linked when a URL exists
- line 2: authors, venue, and year

Guidelines:

- reduce vertical spacing compared with the current homepage
- preserve readability despite the denser list
- keep Xu Chen's name visually identifiable in the author line
- avoid turning the list into a table or card grid

## Visual Language

### Background and Color

- pure white page background
- dark text on white
- muted gray separators
- no warm tinted background
- no decorative color fields

### Layout

- centered single-column layout on homepage
- narrower reading width than the current default page layout
- generous but controlled vertical spacing
- subtle section breaks using spacing and thin rules

### Typography

Use a restrained mixed typography system:

- a more natural serif-style treatment for the name and possibly high-level headings
- clean sans-serif body text for paragraph and metadata content

Constraints:

- typography should feel fresh and natural, not corporate SaaS-like
- typography should remain simple and unobtrusive
- avoid exaggerated display styling

### Components to Avoid

- navigation-heavy masthead presence on the homepage
- sidebar-style author widgets
- boxed profile cards
- large filled buttons
- colored background panels

## Homepage-Specific Template Behavior

The redesign should be implemented as homepage-specific behavior rather than as a site-wide theme rewrite.

Required homepage-specific effects:

- hide the top masthead/navigation on `/`
- hide the default sidebar author-profile block on `/`
- suppress the `About Me` page title on `/`
- render the homepage content in a centered single-column layout

Other pages should continue using the current theme structure.

## Content Editing Rules

- Reuse the existing homepage content as the source of truth.
- Tighten and restructure the wording, but do not invent new factual claims.
- Preserve publication metadata already present on the homepage.
- Do not add homepage sections for pages the user explicitly said to ignore.

## Validation Requirements

Before implementation is considered complete, local preview should confirm:

- the homepage loads without the masthead on desktop and mobile
- the homepage no longer shows the default sidebar author card
- the homepage no longer shows the `About Me` title
- the hero block remains balanced with the avatar and inline links
- the publication list is easy to scan despite including all items
- homepage links are clickable
- non-homepage pages still render with their original layout behavior

## Risks and Constraints

- The homepage currently relies on shared theme layouts, so homepage-only hiding behavior must not leak into other pages.
- Publication titles vary in length, so compact spacing must still tolerate wrapping.
- The design should preserve simplicity even though the homepage retains the full publication list.

## Implementation Boundary for Planning

The later implementation plan should stay focused on homepage-scoped template, content, and style changes. It should not expand into a broader theme refactor unless required to support the homepage-only behavior cleanly.
