RISCV = riscv64-unknown-elf-gcc
CFLAGS = -march=rv32ima -mabi=ilp32 -D__vexriscv__ -DUART_POLLING
FILENAME = hello
all:
	$(RISCV) $(CFLAGS)  $(FILENAME).c -o $(FILENAME)
clean:
	rm $(FILENAME)