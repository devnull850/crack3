all: trunc
	chmod +x crack
	rm crack0

trunc: zero
	dd if=crack0 of=crack bs=1 count=14408

zero: strip
	dd if=zero of=crack0 conv=notrunc bs=1 seek=40 count=8
	dd if=zero of=crack0 conv=notrunc bs=1 seek=60 count=2

strip: cp
	strip --strip-all crack0

cp: crack0
	dd if=blob of=crack0 conv=notrunc bs=1 seek=4774 count=20

crack0: crack.c
	gcc -Wall -Werror -o crack0 crack.c

.PHONY:
clean:
	rm crack
