#!/usr/bin/env bash
set -e
if [ -z "$SECRET_ARN" ] || [ -z "$DB_HOST" ]; then
  echo "SECRET_ARN and DB_HOST must be set"
  exit 1
fi
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$SECRET_ARN" --query SecretString --output text)
DB_PASS=$(echo "$SECRET_JSON" | jq -r .password)
DB_USER=$(echo "$SECRET_JSON" | jq -r .username)
DB_PORT=${DB_PORT:-3306}
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;"