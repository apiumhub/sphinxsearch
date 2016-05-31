FROM docker.apiumtech.io/apiumbase:v-0.0.0
RUN apt-get update && apt-get install libexpat1-dev libmysqld-dev libpq-dev -y && apt-get clean
ENV RE2_VERSION "2015-11-01"
ENV SPHINX_VERSION "2.1.6-release"
RUN wget -nv -O - http://snowball.tartarus.org/dist/libstemmer_c.tgz | tar zx
RUN wget -nv -O - https://github.com/google/re2/archive/$RE2_VERSION.tar.gz | tar zx
RUN wget -nv -O - http://sphinxsearch.com/files/sphinx-$SPHINX_VERSION.tar.gz | tar zx
RUN cp -R libstemmer_c/* sphinx-$SPHINX_VERSION/libstemmer_c/
RUN sed -i -e 's/stem_ISO_8859_1_hungarian/stem_ISO_8859_2_hungarian/g' sphinx-$SPHINX_VERSION/libstemmer_c/Makefile.in
RUN cp -R re2-$RE2_VERSION/* sphinx-$SPHINX_VERSION/libre2/
RUN cd sphinx-$SPHINX_VERSION && ./configure --enable-id64 --with-mysql --with-pgsql --with-libstemmer --with-libexpat --with-iconv --with-unixodbc --with-re2
RUN cd sphinx-$SPHINX_VERSION && make
RUN cd sphinx-$SPHINX_VERSION && make install

EXPOSE 9312

RUN mkdir -p /var/sphinx
RUN mkdir -p /var/lib/sphinxsearch/data/users
RUN mkdir -p /var/log/sphinxsearch/ && touch /var/log/sphinxsearch/searchd.log

WORKDIR /var/sphinx

COPY start.sh .

CMD ["bash", "/var/sphinx/start.sh"]