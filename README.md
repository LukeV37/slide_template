# Argonne / ATLAS Beamer Slide Template

A LaTeX Beamer presentation template that replicates the official Argonne National Laboratory / ATLAS branded visual style. Produces 16:9 PDF slides with a pixel-perfect layout derived from the original PowerPoint/ODP reference template.

## Overview

All Beamer chrome (headers, footers, navigation symbols, frametitle) is stripped and replaced with hand-crafted TikZ overlays that reproduce the Argonne/ATLAS branded slide design — including the signature stacked diagonal color-bar motif in red (`#CD202C`), green (`#77B300`), and blue (`#0081CA`).

## Repository Structure

```
.
├── logos/
│   ├── Argonne-Logo.png       # Argonne National Laboratory logo
│   └── ATLAS-Logo.png         # ATLAS logo
├── src/
│   ├── title.tex              # Title slide
│   └── blank.tex              # Content slide template (copy this for new slides)
├── template/
│   ├── Argonne_Template.odp   # Original LibreOffice Impress source (design reference)
│   └── Argonne_Template.pdf   # Rendered reference PDF
├── tmp/                       # Build output directory (git-ignored)
├── main.tex                   # Root LaTeX document (entry point)
└── makefile                   # Build system (GNU Make + latexmk)
```

## Requirements

- **TeX Live 2026** (or later) with the following packages:
  - `beamer`
  - `tikz`
  - `graphicx`
  - `fontenc`
  - `tgheros` (TeX Gyre Heros — Helvetica/Arial-compatible font)
- **latexmk**
- **GNU Make**

The `makefile` expects a local TeX Live installation at `~/Software/texlive/2026/bin/x86_64-linux`. Adjust the `TEXLIVE` variable at the top of `makefile` if your installation is elsewhere.

## Building

```bash
# Compile to tmp/main.pdf
make

# Remove all build artifacts
make clean
```

You can also compile directly without Make:

```bash
latexmk -pdf main.tex
# or
pdflatex main.tex && pdflatex main.tex
```

The output PDF is written to `tmp/main.pdf`.

## Customizing Slide Metadata

Edit the metadata block in `main.tex`:

```latex
\title{Title}
\author{Author Name}
\institute{Argonne National Laboratory}
\date{\today}
```

These values are automatically inserted into the title slide by `\inserttitle`, `\insertauthor`, and `\insertinstitute`.

## Adding a New Slide

1. Copy the content slide template:
   ```bash
   cp src/blank.tex src/slide02.tex
   ```

2. Add an `\input` line in `main.tex` (after the existing slides):
   ```latex
   \input{src/slide02.tex}
   ```

3. In `src/slide02.tex`, replace `Slide Title` and the placeholder `itemize` list with your content.

Any new `src/*.tex` file is automatically picked up as a Make dependency — saving the file triggers a rebuild.

## Slide Anatomy

### Title Slide (`src/title.tex`)

- Both logos displayed large across the top
- Two mirrored groups of stacked diagonal colored rectangles (left and right) flank a centered white title box
- Author and institute rendered below in a centered text block
- Date (bottom-left) and page counter (bottom-right) drawn by `\slideheaderfooter`

### Content Slide (`src/blank.tex`)

- Stacked diagonal color bars in the header (red, green, blue) with a white title bar on top
- Small Argonne and ATLAS logos in the top-right corner
- A `minipage` content area below the header for body text, lists, figures, etc.
- Date and page counter from `\slideheaderfooter`

### Brand Colors

| Name  | Hex       |
|-------|-----------|
| Red   | `#CD202C` |
| Green | `#77B300` |
| Blue  | `#0081CA` |

## Previewing Slides as Images

To visually inspect the output, convert the PDF pages to PNG images using `pdftoppm` (part of the `poppler-utils` package):

```bash
pdftoppm -r 150 tmp/main.pdf tmp/slide -png
```

This writes one PNG per page into `tmp/`:

```
tmp/slide-1.png   # page 1 (title slide)
tmp/slide-2.png   # page 2
# ...
```

The `-r 150` flag sets 150 DPI — sufficient for on-screen review. Increase to `-r 300` for higher-fidelity inspection.

Open any page directly:

```bash
xdg-open tmp/slide-1.png   # Linux desktop
open tmp/slide-1.png        # macOS
```

## Design Notes

- **Canvas:** 160 mm × 90 mm (Beamer `aspectratio=169`)
- **Font:** TeX Gyre Heros (metric-compatible Helvetica/Arial substitute)
- **TikZ coordinates** are taken directly from the ODF XML of `template/Argonne_Template.odp` and converted mathematically to the 160 × 90 mm canvas
- The `\slideheaderfooter` macro is defined once in `main.tex` and called at the end of every frame for consistent date and page numbering
