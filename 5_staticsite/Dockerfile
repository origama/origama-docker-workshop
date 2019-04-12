FROM vorakl/alpine-pelican as build
WORKDIR /site
copy ./input ./input
copy pelicanconf.py .
RUN pwd && ls -ltr && mkdir output && pelican ./input -o ./output -s ./pelicanconf.py

FROM nginx
COPY --from=build /site/output /usr/share/nginx/html
