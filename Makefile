CXX ?=g++
OPT ?= -g
FLAGS= $(OPT) -std=c++17
CFLAGS= -c $(FLAGS) -Wfatal-errors
SOURCES=partition.cc pamir.cc assembler.cc genome.cc aligner.cc extractor.cc common.cc bam_parser.cc sam_parser.cc record.cc sort.cc logger.cc
LDFLAGS=-lm -lz
OBJECTS=$(SOURCES:.cc=.o) 
EXECUTABLE=pamir
all: snp rc es sm mf cm
basic: snp rc es mf cm

rc: 
	g++ $(OPT) -o recalibrate recalibrate.cc
cm: 
	g++ $(OPT) -o cleanmega clean_megablast.cc
es: 
	g++ $(OPT) -o extract_support extract_support.cc common.cc
sm:
	g++ $(OPT) -o smoother -g -std=c++1y -Wfatal-errors smoother.cc
mf: 
	make -C mrsfast

snp: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) 
	$(CXX) $(OBJECTS) $(LDFLAGS) -o $@

.cc.o:
	$(CXX) $(CFLAGS) $< -o $@ 

clean:
	rm -f *.o pamir recalibrate extract_support smoother cleanmega
