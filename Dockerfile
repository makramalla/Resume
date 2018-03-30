FROM akohlbecker/base:latest

RUN set -x && \
    apt-get --quiet --yes update && \
    apt-get --quiet --yes install nodejs npm jq git && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    ln -s /usr/bin/nodejs /usr/bin/node

ENV PATH "./node_modules/.bin:$PATH"
EXPOSE 4000

WORKDIR /tmp
ADD package.json /tmp/package.json
RUN npm install

COPY . /app/resume
WORKDIR /app/resume

RUN set -x && \
    mv /tmp/node_modules /app/resume && \
    resume export --format html --theme slick dist/index.html && \
    sed -i 's|http://fonts.googleapis.com|https://fonts.googleapis.com|' dist/index.html && \
    sed -i 's|http://bootswatch.com|https://bootswatch.com|' dist/index.html && \
    sed -i "s|</head>|<meta name=\"description\" content=\"$(jq -r ".basics.summary" resume.json)\" />\n</head>|" dist/index.html && \
    gzip --keep --best dist/index.html

USER nobody
CMD ["node", "index.js"]
