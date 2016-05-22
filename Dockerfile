FROM docker.apiumtech.io/apiumbase:v-0.0.0

RUN apt-get update && apt-get install sphinxsearch -y && apt-get clean

EXPOSE 9312

CMD searchd