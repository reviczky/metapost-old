
srcdir = .

RM = rm
LD = gcc
CC = gcc
CTANGLE = ctangle

CFLAGS = -Wall -W -g
OBJECTS = avl.o mp.o


newmpost: $(OBJECTS) avl.h
	$(LD) -o newmpost $(OBJECTS) -lm

mp.c: $(srcdir)/mp.w
	$(CTANGLE) $(srcdir)/mp.w

$(OBJECTS): %.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	$(RM) *.o newmpost mp.c
