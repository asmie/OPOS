# This is test Makefile to compile simple test bootloader.

C_SOURCES = $(wildcard kernel/core/base/*.c kernel/drivers/*.c kernel/klibc/*.c kernel/boot/*.c)
OBJ = ${C_SOURCES:.c=.o} 

CFLAGS = -g -ffreestanding -Wall -Wextra -fno-exceptions -m32

image.bin: bootloader/bootsector.bin kernel.bin
	cat $^ > image.bin

kernel.bin: kernel/boot/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.elf: kernel/boot/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ 

run: image.bin
	qemu-system-i386 -fda image.bin

# Open the connection to qemu and load our kernel-object file with symbols
debug: image.bin kernel.elf
	qemu-system-i386 -s -fda image.bin -d guest_errors,int &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c
	${CC} ${CFLAGS} -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o image.bin *.elf
	rm -rf kernel/core/base/*.o kernel/klibc/*.o kernel/boot/*.o
