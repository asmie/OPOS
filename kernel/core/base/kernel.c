#include <stdio.h>
#include <string.h>

#include <kernel/tty.h>
 
void kernel_main(void)
{
	const char *hello = "Hello, kernel World!";

	terminal_initialize();
	__builtin_printf("\"%s\" has %d chars.\n", hello, strlen(hello));
}
