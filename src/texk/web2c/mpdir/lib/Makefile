
srcdir = .

RM = rm
LD = gcc
CC = gcc
CTANGLE = ctangle

CFLAGS = -Wall -W -g
OBJECTS = avl.o mp.o mpost.o


newmpost: $(OBJECTS) avl.h
	$(LD) -o newmpost $(OBJECTS) -lm

.w.c:
	$(CTANGLE) $<

$(OBJECTS): %.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	$(RM) *.o newmpost mp.c mpost.c mplib.h
