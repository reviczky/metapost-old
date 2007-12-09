# $Id: Makefile,v 1.4 2005/03/21 15:25:51 taco Exp $
# Makefile for MetaPost documentation.  Public domain.
# Rules for the groff/troff docs are in TeX Live,
# texmf-dist/doc/metapost/base/Makefile.

pdflatex = pdflatex
bibtex = bibtex
mpost = mpost -tex=tex

all: mpman.pdf mpintro.pdf mpgraph.pdf grdemo.pdf

mpgraph.pdf: mpgraph.tex mpgraph.bib mpgraph.mp
	$(mpost) mpgraph
	$(pdflatex) mpgraph
	$(bibtex) mpgraph
	$(pdflatex) mpgraph
	$(pdflatex) mpgraph

mpintro.pdf: mpintro.tex mpintro.bib examples.mp manfig.mp
	$(mpost) examples
	$(mpost) manfig
	$(pdflatex) mpintro
	$(bibtex) mpintro
	$(pdflatex) mpintro
	$(pdflatex) mpintro

mpman.pdf: mpman.tex mpman.bib mpman.ist manfig.mp 
	$(mpost) manfig
	$(pdflatex) mpman
	$(bibtex) mpman
	$(pdflatex) mpman
	$(pdflatex) mpman
	makeindex -s mpman.ist mpman
	$(pdflatex) mpman

clean distclean:
	rm -f *.aux *.bbl *.blg *.dvi *.log *.mpx *.mps
	rm -f *.idx *.ilg *.ind *.toc
