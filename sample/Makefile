
CXXFLAGS = -g `root-config --cflags --glibs`
ALLLIBS = header main

all: $(ALLLIBS)

header:  simple.h exLinkDef.h
	rootcint -f simpDict.cxx -c simple.h exLinkDef.h

main : simple.cpp simpDict.cxx
	mkdir -p build
	g++ simple.cpp simpDict.cxx  -o build/simple $(CXXFLAGS)

clean:
	rm -f simpDict.cxx *.pcm
	rm -rf build
