#!/bin/bash

# Define the namespace and secret name
NAMESPACE="finxpert-dev"
SHARED_SECRET_NAME="shared-secret"

# Define the shared secrets
JWT_SECRET=$(openssl rand -base64 32)         # OVERWRITE, write any (very secure) string here.

# RabbitMQ is legacy for this app, but keep it as is, don't remove it
RABBITMQ_USER="expensio-rabbitmq" 
RABBITMQ_PASSWORD="12345678"
RABBITMQ_HOST="rabbitmq-srv"
RABBITMQ_PORT="5672"
RABBITMQ_URL="amqp://$RABBITMQ_USER:$RABBITMQ_PASSWORD@$RABBITMQ_HOST:$RABBITMQ_PORT"


KAFKA_BROKER_URL="kafka-srv:9092"

OPENAI_API_KEY=""     # OVERWRITE with your OPENAI API KEY(can't add here in public repo as openai automatically bans the key if it is public. Contact developer for the key)
# NOTE:: The OPENAI_API_KEY is required for the smart-ai service to work.
GUEST_RESET_TOKEN=$(openssl rand -base64 32)  # OVERWRITE, write any (very secure) string here.

EXPENSE_SERVICE_URL="http://expense-srv.finxpert-dev.svc.cluster.local:3000/api/expense"
INCOME_SERVICE_URL="http://income-srv.finxpert-dev.svc.cluster.local:3000/api/income"
FINANCIALDATA_SERVICE_URL="http://financial-data-srv.finxpert-dev.svc.cluster.local:3000/api/financial-data"
SMART_AI_SERVICE_URL="http://smart-ai-srv.finxpert-dev.svc.cluster.local:3000/api/smart-ai"

# Create the shared secret in Kubernetes
kubectl create secret generic $SHARED_SECRET_NAME \
  --namespace=$NAMESPACE \
  --from-literal=JWT_SECRET=$JWT_SECRET \
  --from-literal=RABBITMQ_USER=$RABBITMQ_USER \
  --from-literal=RABBITMQ_PASSWORD=$RABBITMQ_PASSWORD \
  --from-literal=RABBITMQ_URL=$RABBITMQ_URL \
  --from-literal=EXPENSE_SERVICE_URL=$EXPENSE_SERVICE_URL \
  --from-literal=INCOME_SERVICE_URL=$INCOME_SERVICE_URL \
  --from-literal=FINANCIALDATA_SERVICE_URL=$FINANCIALDATA_SERVICE_URL \
  --from-literal=SMART_AI_SERVICE_URL=$SMART_AI_SERVICE_URL \
  --from-literal=OPENAI_API_KEY=$OPENAI_API_KEY \
  --from-literal=KAFKA_BROKER_URL=$KAFKA_BROKER_URL \
  --from-literal=GUEST_RESET_TOKEN=$GUEST_RESET_TOKEN \
  --dry-run=client -o yaml | kubectl apply -f -
