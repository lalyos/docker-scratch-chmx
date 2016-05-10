build:
	docker run -v $(shell pwd):/data -w /data lalyos/alpine-build:edge gcc -static chmx.c -o chmx

certs-test: build
	docker build -t lalyos/scratch-chmx:certs -f Dockerfile.certs .
	# add runnable perm to itself
	docker run --rm lalyos/scratch-chmx:certs /bin/chmx /bin/chmx

test: build
	docker build -t lalyos/scratch-chmx .
	# add runnable perm to itself
	docker run --rm lalyos/scratch-chmx:latest /bin/chmx /bin/chmx
