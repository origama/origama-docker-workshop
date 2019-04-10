## Example 3 : Static Website generator

Multistage docker compose file using Pelican as site generator

`input` contains the markdown files to be converted to html and to be put in `output`

```
mkdir input output

#generating 
docker run --rm -v $(pwd):/site vorakl/alpine-pelican pelican /site/input -o /site/output -s site/pelicanconf.py
```