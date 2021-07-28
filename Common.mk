TARGET = d3d11_player

SRCS = d3d11_player.cpp

OBJS = $(SRCS:.cpp=.o)

CXXFLAGS = -O2 -fdebug-prefix-map='/mnt/c/'='c:/' -Wall -I./sdk/include/

LIB=./sdk/lib
LDFLAGS = -Wl,-L$(LIB)

LIBS = -lvlc -ld3d11 -ld3dcompiler_47 -luuid

ifeq ($(ARCH), x86_64)
BIN_PREFIX = x86_64-w64-mingw32
COMPILEFLAG = m64
else
BIN_PREFIX = i686-w64-mingw32
COMPILEFLAG = m32
endif

OUTPUT = $(TARGET).exe

CXX = $(BIN_PREFIX)-c++
STRIP = $(BIN_PREFIX)-strip

all: $(OUTPUT)

copy: $(OUTPUT)
ifndef NOSTRIP
	$(STRIP) $(OUTPUT)
endif
	cp -f $(OUTPUT) ../Assets/$(OUTPUT)

clean:
	rm -f $(OUTPUT) $(OBJS)

$(OUTPUT): $(OBJS)
	$(CXX) $(LDFLAGS) -o $(OUTPUT) $(OBJS) $(LIBS)

.cpp.o:
	$(CXX) $(CXXFLAGS) -$(COMPILEFLAG) -c -o $@ $<