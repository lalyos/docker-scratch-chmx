build:
	docker run -v $(shell pwd):/data -w /data lalyos/alpine-build:edge gcc -static chmx.c -o chmx

test: build
	docker build -t lalyos/chmx .
	# add runnable perm to itself
	docker run --rm lalyos/chmx:latest /bin/chmx /bin/chmx
