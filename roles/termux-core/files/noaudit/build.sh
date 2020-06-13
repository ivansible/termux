#!/bin/sh -x
ARCH=aarch64
gcc -c -fPIC noaudit.c
gcc -shared -Wl,-soname,noaudit.${ARCH}.so -o noaudit.${ARCH}.so noaudit.o -lc
