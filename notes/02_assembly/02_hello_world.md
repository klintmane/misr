# Hello World in Assembly

## Loading code at 0x7c00

The first thing we need to do before we can see a `Hello World` on the screen, is to set up the boot process.

One way to tell the assembler where we want it to put our program is through `ORG`. It's used to set something called the assembler location counter.

```asm
ORG 0x7c00
```

We're offseting the origin of our program, telling the assembler to put it in the address from where the bootloader is called.

Normally we would start at address `0` and jump to that.

## Generating 16 bit code

We then need to tell the assembler we're generating 16 bit code.

```asm
BITS 16
```

## Calling an interrupt

An [interrupt](#links) is how programs call into BIOS functionality. We use the `int` keyword followed by an interrupt code.
Depending on the code, the BIOS will check the values of CPU registers and use those for performing the call.

Think of the interrupt code as a library, and the register values as functions and their arguments.

To print text on the screen we do the following:

```asm
mov ah, 0eh ; We set the register `ah` to the value `0eh`
mov al, 'A' ; We set the `al` register to the value 'A'

int 0x10 ; We interrupt with code `0x10` - think of it as a package called `Video`
         ; If `0x10` and `ah = 0eh`, BIOS will print the value on register `al` to the screen ( Video.TeletypeOutput(al) )
         ; Check [http://www.ctyme.com/intr/rb-0106.htm] for more
```

The links section has a rlist of [interrupts](#links) you can refer to and a jump table - so you can search by code.

## Jump

We the add a `jmp $` statement to force our code to jump to the current statement - the jump itself, forcing the code to jump infinitely and not run the boot signature.

## Adding a boot signature

Finally we need to add a boot signature at the end, we do that using assembler (`nasm`) directives (`times`, `db`, `dw`), we first need to jump to the last two bytes of the section of memory, that's where the BIOS will be looking for the bootloader.

After writing our code, we need to move to the end of the section. We first need to find out how much we need to move.

To calculate that, we need the start of the memory section ($$), the current statements location ($), that gives us the relative position and substract it from 510.

Supposing the code starts at address 876 and is 100 bytes long until the current statement.

```
            $$ = 876
             $ = 876 + 100 = 976
      ($ - $$) = 976 - 876 = 100
510 - ($ - $$) = 510 - 100 = 410
```

So we need to fill `410` bytes with value `0`, `db 0` fills with zeroes and `times 410 db 0`, fills `410` bytes with `0`.

After that we're at address `510`, and we can set the last two bytes to a `55` byte followed with a `AA` byte with `dw`. The numbers are reversed because x86 is little-endian.

The resulting code is:

```asm
times 510-($ - $$) db 0
dw 0xAA55
```

# Assembling

We create a binary using `nasm`:

```sh
nasm -f bin ./boot.asm -o ./boot.bin
```

If we check the size of the file we'll see that it's exactly 512 bytes, that means we correctly padded with zeroes.

We can even dissasemble the binary file if we want, converting machine code to assembly, it will be identical to our code plus the padding.

The command for that is:

```sh
ndisasm ./boot.bin
```

# Running the bootloader

We can now spin an x86 emulator whose BIOS will run our bootloader. To start the emulator we run the following command:

```sh
qemu-system-x86_64 -hda ./boot.bin
```

We'll get an output of `'A'`.

# Links

- https://en.wikipedia.org/wiki/BIOS_interrupt_call
- http://www.gabrielececchetti.it/Teaching/CalcolatoriElettronici/Docs/i8086_and_DOS_interrupts.pdf
- http://www.ctyme.com/intr/int.htm