/**
 * @brief Kernel string header.
 * @author Piotr Olszewski <asmie@asmie.pl>
 *
 * Prototypes for string functions used in the kernel.
 */

#ifndef _STRING_H
#define _STRING_H 1

#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

int memcmp(const void* p1, const void* p2, size_t n);

void* memcpy(void* __restrict dest, const void* __restrict src, size_t n);

void* memmove(void* dest, const void* src, size_t n);

void*memset(void* s, int c, size_t n);


size_t strlen(const char*);

#ifdef __cplusplus
}
#endif

#endif /* _STRING_H */
