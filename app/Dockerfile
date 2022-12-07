FROM node:13-alpine

RUN mkdir -p /home/app

COPY . /home/app

# set default dir so that next commands executes in /home/app dir
WORKDIR /home/app

# no need for /home/app/server.js because of WORKDIR
CMD ["google-chrome index.html"]
