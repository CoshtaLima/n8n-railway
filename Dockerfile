FROM docker.n8n.io/n8nio/n8n

# Existing ARGS
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER
ARG ENCRYPTION_KEY
ARG CUSTOM_MODULES="@aws-sdk/client-athena@latest"  # Instala o pacote Athena mais recente

# Setting existing ENVs
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY
ENV N8N_LOG_LEVEL=debug

# Instala os pacotes personalizados
USER root
WORKDIR /usr/local/lib/node_modules/n8n
RUN npm install -g @aws-sdk/client-athena
USER node

CMD ["n8n"]
