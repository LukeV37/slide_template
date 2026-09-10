# AGENTS.md

## Purpose

This repository contains a LaTeX Beamer slide deck for the preprocessing study. Future agents should preserve the existing visual style and use the repo's existing workflow rather than inventing a new one.

## Working Style

- Make the smallest correct change.
- Preserve the existing Argonne/ATLAS layout and TikZ-based slide structure.
- Prefer editing existing slide files over creating new abstractions or helpers.
- Do not redesign the deck unless the user explicitly asks for a redesign.

## Repository Layout

- `main.tex`: root document, metadata, shared colors, shared footer macro, slide ordering via `\input`
- `src/title.tex`: title slide layout
- `src/slide02.tex` through `src/slide14.tex`: content slides in order
- `figures/`: all plot assets used by the slides (self-contained, no external paths)
- `logos/`: image assets for logos
- `makefile`: canonical build entry point
- `tmp/main.pdf`: canonical build output

## Canonical Build Workflow

Always use the repo build command:

```bash
make
```

Do not prefer direct `latexmk` calls when working in this repository unless the user explicitly asks for that. The project already defines the intended build in `makefile`.

After slide edits, rebuild with `make` and report the output path:

- output PDF: `tmp/main.pdf`

## Slide Editing Workflow

### Metadata

Edit slide metadata in `main.tex`:

- `\title{...}`
- `\subtitle{...}`
- `\author{...}`
- `\institute{...}`
- `\date{...}`

These values are consumed by `src/title.tex` through `\inserttitle`, `\insertsubtitle`, `\insertauthor`, and `\insertinstitute`.

### Title Slide

For title-page changes:

- text content usually belongs in `main.tex`
- title-page font sizes and placement belong in `src/title.tex`

If the subtitle wraps badly, prefer a simple manual line break in `main.tex` using `\\` rather than adding complicated no-hyphenation logic. Keep the code simple.

### Content Slides

For regular slide content:

- edit an existing `src/*.tex` slide file
- if adding a new slide, create a new `src/slideNN.tex` file and add `\input{src/slideNN.tex}` in `main.tex`
- preserve the existing header bars, logos, and footer unless the user requests a layout change

## Current Project-Specific Conventions

These conventions were established during the current editing session and should be preserved unless the user asks otherwise.

### Aspect Ratio

- The deck is 16:9.
- `main.tex` uses `\documentclass[aspectratio=169]{beamer}`.
- The layout assumes a `160 mm x 90 mm` canvas.

### Title Slide Text Sizing

- Title-page text has already been reduced from the original larger sizing.
- Keep title/subtitle sizing modest unless the user asks for larger text.
- If more adjustment is needed, prefer small font-size changes in `src/title.tex` rather than changing the overall layout.

### Subtitle Wrapping

- Keep the subtitle implementation simple.
- If a word breaks awkwardly, use a manual line break in the subtitle text in `main.tex`.
- Do not reintroduce complex hyphenation suppression code unless explicitly needed.

### Plot Slide Layout

Most content slides show three plots in a row plus a bullet list below. The standard structure is:

- top row of three plots, left to right: loss curve, 1D histogram, 2D histogram
- centered explanatory bullet list below the plots

When updating a slide, keep the horizontal ordering and aligned midline layout unless the user asks for a different arrangement.

### Figure Assets

All figure assets are stored locally in `figures/` with subdirectories matching the run name, e.g.:

- `figures/default_preprocessing_scaled/`
- `figures/no_trim_timestamp_preprocessing_scaled/`
- `figures/loose_preprocessing/`
- `figures/default_preprocessing/`
- `figures/no_trim_timestamp_preprocessing/`
- `figures/trim/`
- `figures/no_trim/`

All `\includegraphics` paths in slide files use `figures/...` relative paths. There are no external paths.

### Slide 2 Text Block Styling

- The explanatory text under the plots is centered as a block.
- The list uses black hyphen bullets instead of the default Beamer blue triangles.
- If the text changes, preserve that styling unless the user asks otherwise.

## Verification Expectations

After non-trivial slide edits:

1. Run `make`
2. Confirm the build succeeds
3. Report `tmp/main.pdf`
4. Mention any warnings that remain relevant

Known warning already present in this repo state:

- `hyperref` warns about `\underline{Luke Vaughan}` inside the author metadata. This is acceptable unless the user asks to remove the warning.

## Editing Guidance For Future Agents

- Prefer direct edits over introducing macros or refactors.
- Keep slide-specific layout changes local to the slide file being edited.
- Avoid changing unrelated slide geometry while adjusting text or plots.
- If a text layout problem can be solved with a manual line break, do that first.
- All figure assets live in `figures/`. Do not introduce external paths.
