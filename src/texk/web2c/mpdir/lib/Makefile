
srcdir = .

KPSEBUILDDIR = ../../../../../build/texk/kpathsea/.libs
KPSESRCDIR = ../../..

RM = rm
LD = gcc
CC = gcc
CTANGLE = ctangle

CFLAGS = -Wall -W -g -I../../..
OBJECTS = avl.o mp.o mpost.o


newmpost: $(OBJECTS) avl.h $(KPSEBUILDDIR)/libkpathsea.a
	$(LD) -o newmpost $(OBJECTS) $(KPSEBUILDDIR)/libkpathsea.a 

mp.c: mp.w mp.ch
	$(CTANGLE) mp.w mp.ch

mpost.c: mpost.w
	$(CTANGLE) mpost.w 

$(OBJECTS): %.o: %.c
	$(CC) -c $(CFLAGS) -I$(KPSESRCDIR) $< -o $@

clean:
	$(RM) *.o newmpost mp.c mpost.c mplib.h
