
srcdir = .

CC = gcc
OBJECTS = avl.o mp.o

newmpost: $(OBJECTS) avl.h
	gcc -o newmpost $(OBJECTS) -lm

mp.c: $(srcdir)/mp.w
	ctangle $(srcdir)/mp.w
