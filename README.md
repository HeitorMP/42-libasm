# 42-libasm

This repository contains the `libasm` project from 42 School. The objective of the project is to create a small library in Assembly language that replicates some standard C library functions.

## Table of Contents
- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Functions](#functions)
- [Lessons Learned](#lessons-learned)
- [Assembly Basics](#assembly-basics)
- [References](#references)

## Introduction
The `libasm` project challenges students to understand low-level programming by implementing a series of C functions in Assembly (x86_64 NASM). This allows for a deeper understanding of how functions are managed at the hardware level, focusing on stack manipulation, function calling conventions, and efficient memory management.

## Installation
To compile and test the library, ensure you have `nasm` (Netwide Assembler) installed.

```bash
# Clone the repository
git clone https://github.com/yourusername/42-libasm.git
cd 42-libasm

#update the submodules
git submodule update --init --recursive

# Compile the library
make
```

## Usage

After compilation, the library can be linked to other projects. Here’s an example of compiling a test file with libasm.a:

gcc -o test_program test.c -L. -lasm
./test_program

### This repo already has a test as a submodule from:
[Try my test](https://github.com/HeitorMP/42-libasm-tester)


### !First compile the main project!

### Edit the tests.h File

Open the tests.h file inside the tester folder and update the path to the libasm.h header file to point to its correct location in your environment.

```
// path to your libasm.h
# include "../headers/libasm.h" <- change thie if needed
```

### Edit the Makefile

Open the Makefile inside the tester folder and update the path to the libasm.a library file so it points to the correct location.

```
PATH_TO_LIBASM_A  = ../libasm.a <- change thie if needed
```

Compile and Run the Tester
    Compile
    After configuring the files, compile the tester by running:
```
make
```

Run the Tester
Once compiled, run the tester with:

```
./libasm-tester
```

## Functions

The library implements the following standard C library functions in Assembly:

    Mantadory:
    - ft_strlen: calculates the length of a string.
    - ft_strcpy: copies a string.
    - ft_strcmp: compares two strings.
    - ft_write: writes data to a file descriptor.
    - ft_read: reads data from a file descriptor.
    - ft_strdup: duplicates a string.

    Bonus:
    - ft_atoi_base: convert any base do decimal
    - ft_list_push_front: add new node in front of linked list
    - ft_list_size: calculates the length of a linked list
    - ft_list_sort: sort a linked list
    - ft_list_remove_if: remove a node for a linked list with a condition



Each function is written in NASM x86_64 Assembly and follows the System V AMD64 ABI calling convention.

## Lessons Learned

This project provided a hands-on experience in Assembly, teaching concepts such as:

    Stack management: Learning how to manage the stack manually, including pushing and popping values, was essential.
    Calling conventions: Understanding how arguments are passed in registers (first six) and the stack for subsequent arguments in x86_64.
    Efficient memory management: Optimizing memory usage through Assembly operations and understanding how to manage buffer overflows and memory alignment.
    Error handling: Implementing robust error handling directly through Assembly, including setting errno.

## Assembly Basics

Here are some fundamental concepts of Assembly that were useful for this project:
Registers

Registers are small storage locations in the CPU used for quick access to data. In x86_64, common registers include:

    General-purpose registers: rax, rbx, rcx, rdx, rsi, rdi, rbp, rsp, etc.
    Special-purpose registers: rip (instruction pointer), rsp (stack pointer), rbp (base pointer).

System V AMD64 ABI Convention

In this calling convention:

    The first six arguments are passed in registers rdi, rsi, rdx, rcx, r8, and r9.
    The return value is placed in rax.
    The stack grows downwards, meaning values pushed onto it have progressively lower memory addresses.

Stack Management

The stack is a Last In, First Out (LIFO) structure used to store return addresses, function arguments, and local variables. Proper stack alignment (16 bytes) is crucial in x86_64.
Basic Assembly Instructions

    mov: Moves data from one location to another.
    push/pop: Places data onto or removes data from the stack.
    call/ret: Calls a function or returns from one.
    cmp and j* (e.g., je, jne): Compare values and jump based on conditions.

## References

[NASM Documentation](https://www.nasm.us/docs.php)

[x86-64 Assembly Guide by WikiBooks](https://en.wikibooks.org/wiki/X86_Assembly)

