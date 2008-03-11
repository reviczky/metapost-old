# Makefile for MetaPost documentation.  Public domain.
# Rules for the groff/troff docs are in TeX Live,
# texmf-dist/doc/metapost/base/Makefile.

latex = latex
pdflatex = pdflatex
dvips = dvips
bibtex = bibtex
mpost = mpost -tex=tex

pdf: mpman.pdf mpintro.pdf mpgraph.pdf grdemo.pdf
ps: mpman.ps mpintro.ps mpgraph.ps

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

mpgraph.ps: mpgraph.tex mpgraph.bib mpgraph.mp
	$(mpost) mpgraph
	$(latex) mpgraph
	$(bibtex) mpgraph
	$(latex) mpgraph
	$(latex) mpgraph
	$(dvips) mpgraph

mpintro.ps: mpintro.tex mpintro.bib examples.mp manfig.mp
	$(mpost) examples
	$(mpost) manfig
	$(latex) mpintro
	$(bibtex) mpintro
	$(latex) mpintro
	$(latex) mpintro
	$(dvips) mpintro

mpman.ps: mpman.tex mpman.bib mpman.ist manfig.mp 
	$(mpost) manfig
	$(latex) mpman
	$(bibtex) mpman
	$(latex) mpman
	$(latex) mpman
	makeindex -s mpman.ist mpman
	$(latex) mpman
	$(dvips) mpman

clean distclean:
	rm -f *.aux *.bbl *.blg *.dvi *.log *.mpx *.mps
	rm -f *.idx *.ilg *.ind *.toc *.out
