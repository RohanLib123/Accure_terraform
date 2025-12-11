#!/bin/bash
set -e
if grep -qi "amazon linux" /etc/os-release 2> /dev/null; then
    yum update -y
    yum install -y jq
    yum install -y mariadb
else
    apt-get update -y
    apt-get install -y jq mysql-client
fi

if command -v aws >/dev/null 2>&1; then
  SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$SECRET_ARN" --query SecretString --output text)
  DB_PASS=$(echo "$SECRET_JSON" | jq -r .password)
  mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;"
else
  echo "aws cli not installed - skipping test query"
fi