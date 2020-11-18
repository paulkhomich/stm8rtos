SRC := $(wildcard *.s)

all: $(SRC)
	sdasstm8 -los kernel.s 
	sdcc -mstm8 kernel.rel
	mkdir -p build
	mv kernel.* build/
	mv ./build/kernel.s ./
dump:
	stm8-objdump -D -mstm8 ./build/kernel.ihx

backup:
	mkdir -p backup
	cp *.s backup/

clean:
	rm -rf build
