
srcdir = ../src/texk/web2c

CC = gcc
OBJECTS = avl.o mp.o

newmpost: $(OBJECTS) avlstuff.h
	gcc -o newmpost $(OBJECTS) -lm

mp.c: $(srcdir)/mp.w
	ctangle $(srcdir)/mp.w
