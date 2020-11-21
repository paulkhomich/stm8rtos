SRC := $(wildcard *.s)

all: $(SRC)
	sdasstm8 -losy kernel.s 
	sdcc -mstm8 kernel.rel
	mkdir -p build
	mv kernel.* build/
	mv ./build/kernel.s ./
dump:
	stm8-objdump -D -mstm8 ./build/kernel.ihx

backup: $(SRC)
	mkdir -p backup
	cp *.s backup/

flash:
	make all
	stm8flash -c stlinkv2 -p stm8s105k4 -w ./build/kernel.ihx

clean:
	rm -rf build
