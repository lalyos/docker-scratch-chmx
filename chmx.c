#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: chmx <FILE>\nadds executable flag to the permissions of a file.\n");
        exit(1);
    }
    fprintf(stderr, "chmx: %s\n", argv[1]);
    chmod(argv[1], 00755);

}
