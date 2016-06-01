FROM mhart/alpine-node:latest
MAINTAINER Stéphane Busso <stephane.busso@gmail.com>

RUN apk add --update git && \
    rm -rf /tmp/* /var/cache/apk/*


RUN mkdir /app
WORKDIR /app
ADD package.json /app/package.json
RUN npm install && npm install -g grunt-cli

ADD . /app

VOLUME /app
EXPOSE 9006
CMD 'grunt'

