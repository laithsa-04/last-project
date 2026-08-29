#!/bin/bash
set -e

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="root"

echo "Pushing secrets to Vault..."

docker exec -e VAULT_ADDR=$VAULT_ADDR -e VAULT_TOKEN=$VAULT_TOKEN vault \
  vault kv put secret/myapp/db \
    username=myuser \
    password=mypassword \
    host=db \
    port=5432 \
    dbname=mydb

docker exec -e VAULT_ADDR=$VAULT_ADDR -e VAULT_TOKEN=$VAULT_TOKEN vault \
  vault kv put secret/myapp/config \
    jwt_secret="your-jwt-secret-here" \
    api_key="your-api-key-here"

echo "Secrets pushed successfully!"
