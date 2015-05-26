Once you have static binaries you want to create the smallest possible docker container.

Requirements:
- automated/trusted build: so you have to put your Dockerfile into github
- a minimal docker image, so even alpine or busybox is big (compared to your binry which is probably under 1MB)
- don’t store the binary redundantly in github near to the Dockerfile

This Docker image is my proposed solution.

## Usage

```
FROM lalyos/scratch-chmx
ADD https://bintray.com/yourpackage/v1.2.3/mycli /bin/mycli
RUN [“/bin/chmx”, “/bin/mycli”]

ENTRYPOINT [“/bin/mycli”]
```

## tl;dr

The plan is to create `scratch` based docker images with single static binaries.
For example i want to dockerize [upx](http://upx.sourceforge.net)

### debian package

if you install it on top of `debian:jessie`

```
apt-get update && apt-get install -y upx
```
You end up with an image **over 130 MB**. 

### alpine

You can use alpine as a base. But unfortunately there is no official upx
package. With some work, you can build a static version of upx around **500KB**. 
If you put into alpine, its again **over 5MB**

### scratch

If you put it into `scratch`, well it remains **500KB**. The usual way to create
a scratch base docker images:

```
FROM scratch
ADD upx /upx
```

But this way if you want an automated/trusted docker hub build, you have to 
put the binary into the git repo. Which shouldn’t be there.

So now the final Dockerfile should look like:

```
FROM scratch
ADD https://bintray.com/lalyos/upx/v1.2.3/upx /upx
RUN chmod +x /upx
```

But if you start from scratch there is no `chmod` ?! 

### lalyos/chmx

This can be solved by adding a small tool which is
written in C and can perform a `chmod +x`. Static compiled `chmx`
is about: **88KB**. 

Of course its dockerized as:
```
FROM scratch
ADD chmx /bin/chmx
```

Now you can create an upx container as:

```
FROM lalyos/scratch-chmx

```

