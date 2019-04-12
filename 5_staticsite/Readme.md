# Example 3 : Static Website generator

An example page for Pelican has to be written in MarkDown, like the following

```markdown
Title: Example post
Date:2019-04-08
Category:Test
Slug:example_post

# What should we talk about?

This workshop is awesome man!

```
`input` contains the markdown files to be converted to html and to be put in `output`

## Option 1 : Building the static site by running a container

### Simple build
```
# make sure the filders exist
mkdir input output

#generate site
docker run --rm -v $(pwd):/site vorakl/alpine-pelican pelican /site/input -o /site/output -s site/pelicanconf.py
```

### Build with live preview

```
docker run --rm -it -p 8000:8000 -v $(pwd):/site vorakl/alpine-pelican pelican -l --autoreload /site/input/ -o /site/output -s /site/pelicanconf.py
```

## Option 2 : Use the multistage Dockerfile

We can create a bundle containing both the webserver and the static site

```bash
docker build -t blog
```

## Option 3 : Decouple Webserver and Static site

This makes use of Volumes to store the generated static files



```
docker create blog-vol
```

Access the volume to inspect it 

```
docker run -it --mount source=blog-vol,target=/vol/ --name access_volumes busybox /bin/sh
```

Start the container to generate the static content
```
docker run --rm -it -p 8000:8000 -v $(pwd):/site --mount source=blog-vol,target=/output vorakl/alpine-pelican pelican /site/input/ -o /output -s /site/pelicanconf.py
```
At this point the content is stored on the named volume

We can now start one or more nginx instances to serve the content, thay will all access the same data volume

```
docker run --rm -d -p 8081:80 --mount source=blog-vol,target=/usr/share/nginx/html nginx
docker run --rm -d -p 8082:80 --mount source=blog-vol,target=/usr/share/nginx/html nginx
docker run --rm -d -p 8083:80 --mount source=blog-vol,target=/usr/share/nginx/html nginx
```
Try it out!
[http://127.0.0.1:8081](http://127.0.0.1:8081)
[http://127.0.0.1:8082](http://127.0.0.1:8082)
[http://127.0.0.1:8083](http://127.0.0.1:8083)