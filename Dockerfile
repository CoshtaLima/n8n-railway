FROM node:18-alpine

ARG N8N_VERSION=1.56.1

# Instala dependências básicas
RUN apk --update add graphicsmagick tzdata

USER root

WORKDIR /data

# Atualiza o npm para a versão 11.2.0 (mas lembre-se: essa versão só é compatível com Node 20 ou superior)
RUN npm install -g npm@11.2.0

# Define o diretório de trabalho onde sua aplicação estará

# Instala as dependências de build
RUN apk --update add --virtual build-dependencies python3 build-base

# Instala o n8n globalmente
RUN npm_config_user=root npm install --location=global n8n@${N8N_VERSION}

# Instala o AWS SDK client para Athena dentro do diretório /data
RUN npm install @aws-sdk/client-athena

# Remove as dependências de build
RUN apk del build-dependencies

EXPOSE $PORT

ENV N8N_USER_ID=root

CMD export N8N_PORT=$PORT && n8n start
