
srcdir = .

CC = gcc
CFLAGS = -Wall -W -g
OBJECTS = avl.o mp.o

newmpost: $(OBJECTS) avl.h
	gcc -o newmpost $(OBJECTS) -lm

mp.c: $(srcdir)/mp.w
	ctangle $(srcdir)/mp.w

$(OBJECTS): %.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm *.o newmpost mp.c
