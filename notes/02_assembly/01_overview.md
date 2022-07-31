# Assembly

Every CPU (processor) has an [instruction set](#links), which like the name implies, is a set of instructions (keywords) that can be used or composed to operate the processor, move data to its [registers](#links) (addresses storing information), perform arithmetic operations using special circuits [ALU](#links) and more.

Assembly language is a human-readable version of the instruction set, so we can manipulate the processor using natural language instead of numbers and addresses. Although it looks magical, it's still the same, as its translated into corresponding machine instructions.

The Assembler is what takes in assembly language and turns this (assembles it) into machine instructions.

Machine code then is read by the processor and the numbers passed to it will activate specific sections of it, performing arithmetic, or storing values.

# Minimal x86 Assembly Reference

This is a minimal x86 reference. For a more complete one, check the [i8086 isntruction set reference](#links) in the links section.

## Suffixes

Optional if instruction is unambiguous.

- byte (8 bits): `b`
- word (16 bits): `w`
- long (32 bits): `l`

## Arguments

Eg `src` and `dest` in the following `mov src, dest`.

Note: Impossible for both `src` and `dest` to be memory addresses.

# Constants

- decimal: `$10`
- hex: `$0xff`

## Addresses

- fixed: `(2000)` or `(0x1000+53)` etc.
- dynamic: `(%eax)` or `16(%esp)` etc.
- register: `%eax` or `%bl` etc.

## Registers

- 8-bit: `%al`, `%ah`, `%bl`, `%bh`, `%cl`, `%ch`, `%dl`, `%dh`
- 16-bit: `%ax`, `%bx`, `%cx`, `%dx`, `%si`, `%di`, `%sp`, `%bp`
- 32-bit: `%eax`, `%ebx`, `%ecx`, `%edx`, `%esi`, `%edi`, `%esp`, `%ebp`

![registers](https://www.cs.virginia.edu/~evans/cs216/guides/x86-registers.png)

## Copying Data

| Instruction     | Effect           | Examples                       |
| --------------- | ---------------- | ------------------------------ |
| `mov src, dest` | Copy src to dest | `mov $10,%eax`, `mov $10,%eax` |

## Arithmetic

| Instruction     | Effect                | Examples        |
| --------------- | --------------------- | --------------- |
| `add src, dest` | dest = dest + src     | `add $10, %esi` |
| `sub src, dest` | dest = dest – src     | `sub %eax,%ebx` |
| `mul reg`       | edx:eax = eax \* reg  | `mul %esi`      |
| `div reg`       | edx = edx:eax % reg   | `div %edi`      |
| `inc dest`      | Increment destination | `inc %eax`      |
| `dec dest`      | Decrement destination | `dec (0x1000)`  |

## Function Calls

| Instruction  | Effect                                            | Examples                 |
| ------------ | ------------------------------------------------- | ------------------------ |
| `call label` | Push eip, transfer control                        | `call format_disk`       |
| `ret`        | Pop eip and return                                | `ret`                    |
| `push item`  | Push item (constant or register) to stack         | `pushl $32`, `push %eax` |
| `pop [reg]`  | Pop item from stack; optionally store to register | `pop %eax`, `popl`       |

## Bitwise Operations

| Instruction       | Effect               | Examples                |
| ----------------- | -------------------- | ----------------------- |
| `and src, dest`   | dest = src & dest    | `and %ebx, %eax`        |
| `or src, dest`    | dest = src \| dest   | `orl (0x2000), %eax`    |
| `xor src, dest`   | dest = src ^ dest    | `xor $0xffffffff, %ebx` |
| `shl count, dest` | dest = dest << count | `shl $2, %eax`          |
| `shr count, dest` | dest = dest >> count | `shr $4, (%eax)`        |

## Conditionals and Jumps

| Instruction       | Effect                                                    | Examples             |
| ----------------- | --------------------------------------------------------- | -------------------- |
| `cmp arg1, arg2`  | Compare arg1 to arg2; must precede cond. jump             | `cmp $0, %eax`       |
| `je label`        | Jump to label if arg1 == arg2                             | `je endloop`         |
| `jne label`       | Jump to label if arg1 != arg2                             | `jne loopstart`      |
| `jg label`        | Jump to label if arg2 > arg1                              | `jg exit`            |
| `jge label`       | Jump to label if arg2 >= arg1                             | `jge format_disk`    |
| `jl label`        | Jump to label if arg2 < arg1                              | `jl error`           |
| `jle label`       | Jump to label if arg2 <= arg1                             | `jl finish`          |
| `test reg, imm`   | Bittwise cmp register and const; must precede `jz`, `jnz` | `test $0xffff, %eax` |
| `jz label`        | Jump to label if bits unset (zero)                        | `jz looparound`      |
| `jnz label`       | Jump to label if bits set (!=zero)                        | `jnz error`          |
| `jmp label`       | Unconditional relative jump                               | `jmp exit`           |
| `jmp *reg`        | Unconditional absolute jump; arg is a register            | `jmp *%eax`          |
| `ljmp segm, offs` | Unconditional absolute far jump                           | `ljmp $0x10, $0`     |

## Misc

| Instruction | Effect              | Examples |
| ----------- | ------------------- | -------- |
| `nop`       | No-op (opcode 0x90) | `nop`    |
| `hlt`       | Halt the CPU        | `hlt`    |

## Interrupts

For a list of interrupts, refer to [i8086_and_DOS_interrupts](http://www.gabrielececchetti.it/Teaching/CalcolatoriElettronici/Docs/i8086_and_DOS_interrupts.pdf).

# Development Environment

## Assembler

We need to install an Assembler, like `NASM`, which we can install (on Ubuntu) using:

```sh
sudo apt install nasm
```

## Emulator

We also need an emulator for x86 CPUs, we can install one of the most popular, QEMU:

```sh
sudo apt install qemu-system-x86
```

We can then spin up an emulator using the below in a terminal window:

```sh
qemu-system-x86_64
```

# Links

- https://en.wikipedia.org/wiki/Instruction_set_architecture
- https://en.wikipedia.org/wiki/Processor_register
- https://en.wikipedia.org/wiki/Arithmetic_logic_unit
- https://faculty.kfupm.edu.sa/COE/shazli/coe205/Help/8086_instruction_set.html