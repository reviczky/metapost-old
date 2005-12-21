# $Id: Makefile,v 1.2 2004/09/19 21:27:32 karl Exp $
# Makefile for MetaPost in C.  Public domain.

SITEDIR	=..
CC=gcc
OPT=-O2 -g
CFLAGS=$(OPT) -I$(SITEDIR)
LDFLAGS=$(OPT)

# This target is only for testing arithmetic routines.  Run timemath with
# no arguments and use the results printed on standard output to decide if
# the external routines used when `FIXPT' is not defined in site.h work
# properly and run faster than the standard arithmetic routines.

timemath:	time.o cmath.o pmath.o mathtest.o
		$(CC) $(LDFLAGS) -o timemath time.o cmath.o pmath.o mathtest.o

time.o:     test_mpd.h mp.h
mathtest.o: test_mpd.h mp.h
pmath.o:   test_mpd.h mp.h
cmath.o:   test_mpd.h mp.h
	rm -f stamp-orig stamp-trap
	cp test_mpd.h mpd.h
	cp mpmath.c cmath.c
	$(CC) $(CFLAGS) -c cmath.c


.PHONY: clean

clean:
	rm -f *.o timemath mp.h cmath.c

