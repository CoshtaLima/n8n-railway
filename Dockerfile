FROM node:18-alpine

ARG N8N_VERSION=1.56.1

RUN apk --update add graphicsmagick tzdata


USER root

# Separate the build dependencies installation
RUN apk --update add --virtual build-dependencies python3 build-base

# Install n8n globally
RUN npm_config_user=root npm install --location=global n8n@${N8N_VERSION}

# Install AWS SDK client for Athena
RUN npm install @aws-sdk/client-athena

# Remove build dependencies
RUN apk del build-dependencies

WORKDIR /data

EXPOSE $PORT

ENV N8N_USER_ID=root

CMD export N8N_PORT=$PORT && n8n start
