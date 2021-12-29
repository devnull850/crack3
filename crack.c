#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LEN 0x14

int val;

int main(void) {
	int serial;
	char name[LEN+1];

	printf("Enter a name: ");
	fgets(name, LEN, stdin);
	*(strchr(name,0xa)) = 0;

	printf("Enter the serial: ");
	scanf("%d", &serial);

	puts(serial == val ? "Correct" : "Incorrect");

	exit(EXIT_SUCCESS);
}
