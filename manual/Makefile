# $Id: Makefile,v 1.4 2005/03/21 15:25:51 taco Exp $
# Makefile for mpman and mpgraph.
# Public domain.
# 
# (In TeX Live, another Makefile has rules for building grdemo and mpintro.)
#

%.pdf: %.ps
	ps2pdf $< || rm -f $@

%.ps: %.dvi
	dvips -t letter $< -o $@ || rm -f $@

latex = latex '\nonstopmode\input'
pdflatex = pdflatex '\nonstopmode\input'
mpost = TEX=tex mpost

all: mpman.pdf mpgraph.pdf

mpgraph.pdf: mpgraph.tex mpgraph.bib mpgraph.mp
	$(mpost) mpgraph
	$(pdflatex) mpgraph
	bibtex mpgraph
	$(pdflatex) mpgraph
	$(pdflatex) mpgraph

mpman.dvi: mpman.tex mpman.bib mpman.ist manfig.mp 
	$(mpost) manfig
	$(latex) mpman
	bibtex mpman
	$(latex) mpman
	$(latex) mpman
	makeindex -s mpman.ist mpman
	$(latex) mpman

clean distclean:
	rm -f manfig.[0-9]* *.mps
	rm -f *.aux *.bbl *.blg *.dvi *.log *.mpx *.ps
	rm -f *.idx *.ilg *.ind *.toc
