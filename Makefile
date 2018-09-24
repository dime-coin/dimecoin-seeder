INCDIR ?= -I /home/alex/projects/quark/depends/x86_64-unknown-linux-gnu/include
LIBDIR ?= -L /home/alex/projects/quark/depends/x86_64-unknown-linux-gnu/lib
CXXFLAGS = -static -O3 -g0 ${INCDIR} $(LIBDIR)
LDFLAGS = $(CXXFLAGS)

dnsseed: dns.o bitcoin.o netbase.o protocol.o db.o main.o util.o
	g++ -pthread $(LDFLAGS) -o dnsseed dns.o bitcoin.o netbase.o protocol.o db.o main.o util.o -lcrypto

%.o: %.cpp bitcoin.h netbase.h protocol.h db.h serialize.h uint256.h util.h
	g++ -std=c++11 -pthread $(CXXFLAGS) -Wall -Wno-unused -Wno-sign-compare -Wno-reorder -Wno-comment -c -o $@ $<

dns.o: dns.c
	gcc -pthread -std=c99 $(CXXFLAGS) dns.c -Wall -c -o dns.o

%.o: %.cpp

clean:
	rm -f dnsseed
	rm -f *.o
