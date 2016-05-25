FROM docker.apiumtech.io/apiumbase:v-0.0.0

RUN apt-get update && apt-get install sphinxsearch -y && apt-get clean

EXPOSE 9312

RUN mkdir -p /var/sphinx
RUN mkdir -p /var/lib/sphinxsearch/data/users

WORKDIR /var/sphinx

COPY start.sh .

CMD ["bash", "/var/sphinx/start.sh"]