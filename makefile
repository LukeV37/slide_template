TEXLIVE = $(HOME)/Software/texlive/2026/bin/x86_64-linux
export PATH := $(TEXLIVE):$(PATH)

TARGET = main
OUTDIR = tmp

.PHONY: all clean

all: $(OUTDIR)/$(TARGET).pdf

$(OUTDIR)/$(TARGET).pdf: $(TARGET).tex $(wildcard src/*.tex) | $(OUTDIR)
	latexmk -pdf -outdir=$(OUTDIR) $(TARGET).tex

$(OUTDIR):
	mkdir -p $(OUTDIR)

clean:
	latexmk -C -outdir=$(OUTDIR) $(TARGET).tex
	rm -f $(OUTDIR)/$(TARGET).nav $(OUTDIR)/$(TARGET).snm
