# change application name here (executable output name)
TARGET=KamalWeb

# compiler
CC=g++
# debug
DEBUG=-g
# optimisation
OPT=-O0
# warnings
WARN=-Wall

PTHREAD=-pthread

CCFLAGS=$(DEBUG) $(OPT) $(WARN) $(PTHREAD) -pipe

# Added webkit2gtk-4.0 for building with webkit2gtk
GTKLIB=`pkg-config --cflags gmodule-2.0 --libs gtk+-3.0 webkit2gtk-4.0`

# linker
LD=g++
LDFLAGS=$(PTHREAD) $(GTKLIB)

OBJS=    main.o

all: $(OBJS)
	$(LD) -o $(TARGET) $(OBJS) $(LDFLAGS)
    
main.o: src/main.c
	$(CC) -c $(CCFLAGS) src/main.c $(GTKLIB) -o main.o
    
clean:
	rm -f *.o $(TARGET)
