CC=g++
FLAGS= -g -std=c++11 
CFLAGS= -c -Ifmt $(FLAGS) -Wfatal-errors
SOURCES=partition.cc pamir.cc assembler.cc genome.cc aligner.cc  assembler_ext.cc extractor.cc common.cc bam_parser.cc sam_parser.cc record.cc sort.cc fmt/fmt/format.cc
LDFLAGS=-lm -lz
OBJECTS=$(SOURCES:.cc=.o) 
EXECUTABLE=pamir
all: snp pp rc es sm
basic: snp pp rc es

pp: 
	g++ -std=gnu++0x -O3 -o partition_processor partition_processor.cc common.cc
rc: 
	g++ -O3 -o recalibrate recalibrate.cc
es: 
	g++ -O3 -o extract_support extract_support.cc common.cc
sm:
	g++ -O3 -o smoother -Ifmt -g -std=c++1y -Wfatal-errors -I$(BOOST_INCLUDE) smoother.cc fmt/fmt/format.cc

snp: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

.cc.o:
	$(CC) $(CFLAGS) $< -o $@ 

clean:
	rm -f *.o
	rm -f pamir
	rm -f partition_processor
	rm -f recalibrate
	rm -f extract_support
	rm -f smoother
