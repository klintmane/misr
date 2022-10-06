# Freestanding Binary

To start building an operating system, we must first ensure that our code does not rely on OS features (threads, files, heap memory, network, randomness, I/O, etc.).

That means we need to disable OS specific language features and use only language constructs for building our OS. The result is called a freestanding / bare-metal executable.

## 1) Disable stdlib

The Rust standard library depends on OS features and C's `libc` (which is tied to the OS).

After creating a new project, we use the `no_std` attribute:

```rs
#![no_std]

fn main() {}
```

## 2) Implement Panics

Since we are not using a `stdlib`, Rust has no idea what to do when a panic occurs - it can't exit the process. We can define a panic handler:

```rs
use core::panic::PanicInfo; // file/line information

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
```

## 3) `eh_personality`
