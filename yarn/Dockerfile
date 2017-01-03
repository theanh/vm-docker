FROM node:latest

ARG PORT
RUN npm install -g yarn

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE $PORT
CMD [ "npm", "start" ]
