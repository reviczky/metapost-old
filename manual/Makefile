# $Id: Makefile,v 1.4 2005/03/21 15:25:51 taco Exp $
# Makefile for mpman and mpgraph.
# Public domain.
# 
# (In TeX Live, another Makefile has rules for building grdemo and mpintro.)
#

pdflatex = pdflatex
mpost = TEX=tex mpost

all: mpman.pdf mpgraph.pdf

mpgraph.pdf: mpgraph.tex mpgraph.bib mpgraph.mp
	$(mpost) mpgraph
	$(pdflatex) mpgraph
	bibtex mpgraph
	$(pdflatex) mpgraph
	$(pdflatex) mpgraph

mpman.pdf: mpman.tex mpman.bib mpman.ist manfig.mp 
	$(mpost) manfig
	$(pdflatex) mpman
	bibtex mpman
	$(pdflatex) mpman
	$(pdflatex) mpman
	makeindex -s mpman.ist mpman
	$(pdflatex) mpman

clean distclean:
	rm -f *.aux *.bbl *.blg *.dvi *.log *.mpx *.mps
	rm -f *.idx *.ilg *.ind *.toc
