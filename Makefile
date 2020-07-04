all: clean build

build: main.c factor.o
	gcc -m32 main.c factor.o

factor.o: factor.s
	nasm -g -f elf -o factor.o factor.s

clean:
	rm -f a.out
	rm -f factor.o
