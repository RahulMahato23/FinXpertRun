#!/bin/bash

# Define the namespace and secret name
NAMESPACE="finxpert-dev"
EXPENSE_SECRET_NAME="expense-secret"

# Define the Expense service specific secrets
NODE_ENV="development"
SERVICE_NAME="expense"

# FOR MONGO DATABASE, You have two options:
# 1. Make a separate cluster for each DB, and then use the appropriate URL in the MONGO_URI
# 2. Simply make one cluster, and simply modify the connection string with the name of the db
#    keeping all else the same. I am telling the steps for this.

# Example for 2.
# For expense service, the url might be:                                     | DB NAME BELOW |
# MONGO_URI="mongodb+srv://<username>:<password>@something.ipsum.mongodb.net/expensio-expense?retryWrites=true&w=majority&appName=Cluster0"

# FOR income service, the url might be:                                       | JUST CHANGE THIS |
# MONGO_URI="mongodb+srv://<username>:<password>@something.ipsum.mongodb.net/expensio-income?retryWrites=true&w=majority&appName=Cluster0"
# the string after the slash (expensio-expense, expensio-income) are treated as database names.
# So you may keep the rest of the string same and just change these values for each service.
# Just ensure to keep the database name unique for each service (maybe simply write expensio-<service_name>)

MONGO_URI="mongodb+srv://Rahul23:uu0dnAbXAp2MnRWc@cluster0.3m2oh.mongodb.net/expensio-expense?retryWrites=true&w=majority&appName=Cluster0" # OVERWRITE
PORT="3000"

# Create the Expense service specific secret
kubectl create secret generic $EXPENSE_SECRET_NAME \
  --namespace=$NAMESPACE \
  --from-literal=SERVICE_NAME=$SERVICE_NAME \
  --from-literal=NODE_ENV=$NODE_ENV \
  --from-literal=MONGO_URI=$MONGO_URI \
  --from-literal=PORT=$PORT
