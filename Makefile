build:
	docker run -v $(shell pwd):/data -w /data lalyos/alpine-build:edge gcc -static chmx.c -o chmx

test: build
	docker build -t lalyos/scratch-chmx .
	# add runnable perm to itself
	docker run --rm lalyos/scratch-chmx:latest /bin/chmx /bin/chmx
