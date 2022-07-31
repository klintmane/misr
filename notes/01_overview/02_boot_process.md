# Boot Process

## BIOS

BIOS (Basic Input/Output System) belongs to a specific category of computer programs, called firware, which unlike traditional programs, have direct access to hardware and their main goal is to provide low-level control to it.

The BIOS comes pre-installed with the computers board and is the first program to be executed by the CPU from ROM when the computer is turned on.

It initializes and configures everything essentially required by the computer, like hardware.

When run, the BIOS program loads another program, called the [bootloader](#links) which it finds by scanning all storage mediums (USBs, disk drives, etc.).

In each device it looks for something called a [boot sector](#links), which on most disks is the first 512 bytes of the stored data. If the last two bytes are a `0x55` byte followed by a `0xAA` one (called a boot signature), it deems the device bootable.

It will then copy the contents into address `0x07C000` and will execute the content from that address, effectively running the bootloader program.

### BIOS Routines

The BIOS has functionality that programs run by it (eg. bootloader) can use. These are referred to as routines.

Due to BIOS having to be standard between vendors and devices, we can think of the routines like an API specification, code written for one BIOS will work for all BIOS-es.

## Boot Loader

The boot-loader is itself a program, although a very small one, which is executed by the BIOS.

It's located at a specific address in memory, and that's how the BIOS knows where to get it from and run it.

When executed, it's responsible for loading the kernel.

An example of a bootloader would be [GRUB](#links) which is used by operating systems like Linux.

## Kernel

The kernel, like you might expect is another program, which is loaded through the bootloader.

It's responsible for loading all the components composing an operating system.

# x86

During the boot process of a computer that has a x86-based architecture, we're in an environment (operating mode) called [real mode](#links).

What that means is that we have access to 1MB of memory, and that memory is segmented into 20-bits address spaces, limiting us to the size of our bootloader program and it's composition - we have an upper 16 bit limit on variable size.

The bootloader switches the CPU to use [protected mode](#links), which provides programs with 4GB of memory and allows 32-bit ones to be run, and then loads the kernel in the new operating mode.

Protected mode was introduced in 1982 with [Intel 80286](#links) and before that we only had real mode.

# Links

- https://en.wikipedia.org/wiki/BIOS
- https://en.wikipedia.org/wiki/Firmware
- https://en.wikipedia.org/wiki/Bootloader
- https://en.wikipedia.org/wiki/GNU_GRUB
- https://en.wikipedia.org/wiki/Real_mode
- https://en.wikipedia.org/wiki/Protected_mode
- https://en.wikipedia.org/wiki/Intel_80286
- https://en.wikipedia.org/wiki/Boot_sector