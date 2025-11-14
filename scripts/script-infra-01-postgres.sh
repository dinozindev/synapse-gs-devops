#!/bin/bash
# =========================================
# CONFIGURAÇÕES
# =========================================
RESOURCE_GROUP="rg-api-synapse"
LOCATION="brazilsouth"
PROJECT_NAME="synapse"

# PostgreSQL
POSTGRES_SERVER="postgres-${PROJECT_NAME}"
POSTGRES_DB="apidb"
POSTGRES_USER="adminuser"
POSTGRES_PASSWORD="adminpassword"

TAGS="Environment=Production Project=GlobalSolution"

# 1. RESOURCE GROUP
echo "Criando Resource Group..."
az group create \
    --name $RESOURCE_GROUP \
    --location $LOCATION \
    --tags $TAGS

# 2. POSTGRESQL
echo "Criando servidor PostgreSQL..."
az postgres flexible-server create \
    --resource-group $RESOURCE_GROUP \
    --name $POSTGRES_SERVER \
    --location $LOCATION \
    --admin-user $POSTGRES_USER \
    --admin-password "$POSTGRES_PASSWORD" \
    --sku-name Standard_B1ms \
    --tier Burstable \
    --public-access All \
    --storage-size 32 \
    --version 15 \
    --tags $TAGS

echo ""
echo "Aguardando PostgreSQL ficar pronto (verificando status)..."

# Loop de verificação manual — até 20 tentativas
for i in {1..20}; do
  STATUS=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $POSTGRES_SERVER \
    --query "state" -o tsv)

  if [ "$STATUS" == "Ready" ]; then
    echo "Servidor PostgreSQL está pronto!"
    break
  fi

  echo "Tentativa $i/20 — status atual: $STATUS"
  sleep 15
done

if [ "$STATUS" != "Ready" ]; then
  echo "Tempo limite atingido. O servidor PostgreSQL não ficou pronto a tempo."
  exit 1
fi

# Firewall
echo "Configurando regra de firewall (AllowAll)..."
az postgres flexible-server firewall-rule create \
    --resource-group $RESOURCE_GROUP \
    --name $POSTGRES_SERVER \
    --rule-name "AllowAll" \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 255.255.255.255

# Banco de dados
echo "Criando banco de dados '$POSTGRES_DB'..."
az postgres flexible-server db create \
    --resource-group $RESOURCE_GROUP \
    --server-name $POSTGRES_SERVER \
    --database-name $POSTGRES_DB

echo ""
echo "=========================================="
echo " Servidor PostgreSQL criado com sucesso!"
echo "=========================================="
echo ""
echo "Host:             ${POSTGRES_SERVER}.postgres.database.azure.com"
echo "Database:         $POSTGRES_DB"
echo "Admin User:       $POSTGRES_USER"
echo "Admin Password:   $POSTGRES_PASSWORD"
echo "=========================================="