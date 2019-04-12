## Example 3 : Static Website generator

An example page for Pelican has to be written in MarkDown, like the following

```markdown
Title: Example post
Date:2019-04-08
Category:Test
Slug:example_post

## What should we talk about?

This workshop is awesome man!

```
`input` contains the markdown files to be converted to html and to be put in `output`

### Option 1 : Building the static site by running a container

```
# make sure the filders exist
mkdir input output

#generate site
docker run --rm -v $(pwd):/site vorakl/alpine-pelican pelican /site/input -o /site/output -s site/pelicanconf.py
```

### Option 2 : Use the multistage Dockerfile

We can create a bundle containing both the webserver and the static site

```bash
docker build -t blog
```

### Option 3 : Decouple Webserver and Static site

This makes use of Volumes

