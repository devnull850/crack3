# Crackme Number 3

Compile and view the binary produced from the source file.

```
$ gcc crack.c
$ objdump -d a.out
```

Find the address for the main function. Look in the `__libc_csu_init` function for the `call <_init address>` instruction. Change that value to the address of main.

```
12b5:	e8 2f ff ff ff		call	11e9 <main>
```

Find the reference to stdin in main. Modify the 15 bytes before the modified call to main. Load the address of the reference to stdin. Dereference the pointer (an integer) and move the value to the `%eax` register. Move the value in the `%eax` register into the memory location for `val`.

```
12a6:	48 8d 05 63 2d 00 00	lea	0x2d63(%rip),%rax
12ad:	8b 00			mov	(%rax),%eax
12af:	89 05 68 2d 00 00	mov	%eax,0x2d68(%rip)
```

Strip the binary.

```
$ strip --strip-all a.out
```

Zero out the bytes at 0x28, the address for the section header table. Zero out the bytes at 0x3c, the number of section header table entries. Truncate the file by copying over everything until the section header table.

```
$ dd if=a.out of=test bs=1 count=<section header table addres>
```

`make` will do all of the above. Note that the addresses and thus bytes may need to be adjusted based on the machine/OS combination. Step 2 is to figure out a way to scan the binary and make the adjustments build.

