# Argonne / ATLAS Beamer Slide Template

A minimal LaTeX Beamer template for Argonne National Laboratory / ATLAS branded presentations. It produces 16:9 PDF slides with a clean TikZ-based layout, reusable header/footer macros, and optional examples for common slide patterns.

## Overview

All default Beamer chrome is stripped and replaced with hand-crafted TikZ overlays:

- signature Argonne red (`#CD202C`), green (`#77B300`), and blue (`#0081CA`) color bars
- Argonne and ATLAS logos
- consistent date and frame counter footer
- shared `\slideheader{...}` macro for content slides
- compact list styling and reusable code-listing styles

The `main` branch is intentionally content-free: it includes only a title slide and one blank content slide by default.

## Repository Structure

```
.
├── logos/
│   ├── Argonne-Logo.png       # Argonne National Laboratory logo
│   └── ATLAS-Logo.png         # ATLAS logo
├── src/
│   ├── title.tex              # Title slide
│   ├── blank.tex              # Content slide template (copy this for new slides)
│   ├── slide_two_column_example.tex  # Optional generic layout example
│   └── slide_code_example.tex        # Optional generic code/listing example
├── tmp/                       # Build output directory (git-ignored)
├── main.tex                   # Root LaTeX document and shared macros
└── makefile                   # Build system (GNU Make + latexmk)
```

## Requirements

- **TeX Live 2026** or later with:
  - `beamer`
  - `tikz`
  - `graphicx`
  - `fontenc`
  - `tgheros`
  - `listings`
  - `amsmath`
- **latexmk**
- **GNU Make**

The `makefile` expects TeX Live at `~/Software/texlive/2026/bin/x86_64-linux`. Adjust the `TEXLIVE` variable at the top of `makefile` if your installation is elsewhere.

## Building

```bash
# Compile to tmp/main.pdf
make

# Remove build artifacts
make clean
```

You can also compile directly:

```bash
latexmk -pdf -outdir=tmp main.tex
```

The output PDF is written to `tmp/main.pdf`.

## Customizing Slide Metadata

Edit the metadata block in `main.tex`:

```latex
\title{Title}
\subtitle{Subtitle}
\author{Author Name}
\institute{Argonne National Laboratory}
\date{\today}
```

These values are inserted into `src/title.tex` using Beamer's `\inserttitle`, `\insertsubtitle`, `\insertauthor`, and `\insertinstitute` macros.

## Adding a New Slide

1. Copy the blank content slide:

   ```bash
   cp src/blank.tex src/slide02.tex
   ```

2. Add an `\input` line in `main.tex`:

   ```latex
   \input{src/slide02.tex}
   ```

3. In the new slide file:
   - set the title with `\slideheader{Your Slide Title}`
   - replace the placeholder bullets with your content

Any `src/*.tex` file is automatically tracked as a Make dependency, but only files explicitly included from `main.tex` are rendered.

## Optional Example Slides

Two generic examples are included but not rendered by default:

```latex
\input{src/slide_two_column_example.tex}
\input{src/slide_code_example.tex}
```

Use these as copyable patterns for two-column slides and code-heavy slides. Frames containing `lstlisting` or `\lstinputlisting` must use the Beamer `fragile` option:

```latex
\begin{frame}[plain,fragile]
```

## Shared Macros and Styles

### `\slideheader{Title}`

Draws the content-slide header: stacked color bars, slide title, and small Argonne/ATLAS logos.

### `\slideheaderfooter`

Draws the date in the bottom-left and frame counter in the bottom-right. It should appear near the end of every frame.

### `\tightlist`

Reduces list spacing. Use as the first command inside `itemize` or `enumerate` when a compact slide is needed.

### `\takeaway{...}`

Adds a small blue “Key message” callout for the main point of a slide.

### Listing styles

The template defines these `listings` styles:

- `pythoncode`
- `yamlcode`
- `textcode`
- `bashcode`

Example:

```latex
\begin{lstlisting}[style=pythoncode]
def example():
    return True
\end{lstlisting}
```

## Appendix / Backup Slides

If you want backup slides without counting them in the main footer denominator, use this pattern in `main.tex`:

```latex
\input{src/main_deck.tex}
\setmainframenumber
\appendix
\input{src/backup.tex}
```

This keeps main-deck slides numbered as `current/main-total` while backup slides continue after the appendix.

## Slide Anatomy

### Title Slide (`src/title.tex`)

- large Argonne and ATLAS logos across the top
- mirrored stacked diagonal color-bar motifs
- centered white title box
- smaller italic subtitle block
- author and institute block
- shared date/frame footer

### Content Slide (`src/blank.tex`)

- reusable header from `\slideheader{...}`
- content area below the header beginning around 14 mm from the top
- shared date/frame footer

## Design Notes

- **Canvas:** 160 mm × 90 mm via Beamer `aspectratio=169`
- **Font:** TeX Gyre Heros, a Helvetica/Arial-compatible sans-serif
- **Coordinates:** TikZ overlay coordinates use `(current page.north west)` with millimeter units
- **Brand colors:** red `#CD202C`, green `#77B300`, blue `#0081CA`
