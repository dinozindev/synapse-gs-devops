#!/bin/bash

# VARIÁVEIS
RG_NAME="rg-api-synapse"
WEBAPP_NAME="webapp-synapse01"
PLAN_NAME="plan-synapse01"
LOCATION="brazilsouth"

PG_HOST="postgres-synapse.postgres.database.azure.com"
PG_DB="apidb"
PG_USER="adminuser"

# CRIAR APP SERVICE PLAN
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RG_NAME \
  --sku B1 \
  --is-linux

# CRIAR WEB APP (.NET 9)
az webapp create \
  --name $WEBAPP_NAME \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --runtime "DOTNETCORE:9.0"

echo "✔ Infraestrutura criada!"
echo "✔ Web App configurado!"