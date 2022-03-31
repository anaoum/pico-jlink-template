#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/stdio_rtt.h"

int main() {
    stdio_rtt_init();
    unsigned long counter = 0;
    while (1) {
        printf("Hello, World #%lu!\n", counter++);
        sleep_ms(1000);
    }
    return 0;
}
