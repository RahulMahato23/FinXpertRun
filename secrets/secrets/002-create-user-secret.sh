#!/bin/bash

# Define the namespace and secret name
NAMESPACE="finxpert-dev"
USER_SECRET_NAME="user-secret"

# Define the user service secrets
SERVICE_NAME="user"

# NOTE:: For the NODE_ENV, if you change the environment to production, you will get an email with the OTP.
# IF YOU KEEP IT AS "development", YOU WILL NOT GET AN EMAIL WITH THE OTP, but you can get the OTP in the network tab
# of your browser (open the response of the request of send-otp)
NODE_ENV="production"     # MAYBE OVERWRITE

PORT="3000"

# SMTP

# This is required to send the email with the OTP and for other email sending capabilities.
# You can make an account on brevo, you get 300 emails per day for free there.
# Else you are free to use the service of your choice.

EMAIL_PASSWORD="c0DX9qKrxns5S7TY"       # OVERWRITE
EMAIL_FOR_SMTP="88b316001@smtp-brevo.com"       # OVERWRITE
SMTP_HOST="smtp-relay.brevo.com"            # OVERWRITE
SMTP_PORT=587           # MAYBE OVERWRITE, CHECK DOCS OF YOUR EMAIL SENDING SERVICE

PROD_DOMAIN="finxpert.com"    # not important, just let it stay

# Get a free account on Twilio and write the credentials here.
TWILIO_ACCOUNT_SID="ACe3b2cf5028156524cb834f092e7944ac"   # OVERWRITE
TWILIO_AUTH_TOKEN="5f925cd7af46096d8f7fd6001cc697b2"    # OVERWRITE
TWILIO_PHONE_NUMBER="+18569972237"  # OVERWRITE


# We are using postgreSQL db from AIVEN that's why we have to attach the ssl certificate. 
# If you are using a different service, and that does require the ssl certificate,
# you may simply mention your certificate in the DB_AIVEN_POSTGRES_CERT variable wihout any changes.

# If you are using a local db that does not require ssl certificate,
# go to services/user/src/config/db.js and comment lines 14-17 and let
# the DB_AIVEN_POSTGRES_CERT variable stay as is.
DB_USER="avnadmin"            # OVERWRITE
DB_PASSWORD="AVNS_ksKf61W2VVPuQgJXnY1"        # OVERWRITE
DB_HOST="pg-3a185e4c-mrahul230403-bd5f.f.aivencloud.com"            # OVERWRITE
DB_PORT="28230"            # OVERWRITE
DB_NAME="defaultdb"
DB_AIVEN_POSTGRES_CERT="-----BEGIN CERTIFICATE-----
MIIETTCCArWgAwIBAgIUEh9DDIxz+/xPCIN9wWDyAI6ugkIwDQYJKoZIhvcNAQEM
BQAwQDE+MDwGA1UEAww1YTVhMTA2YWUtNTA1YS00YTlhLWFiYTItZjhiNTI5MDhi
NmZjIEdFTiAxIFByb2plY3QgQ0EwHhcNMjUwMzIzMTcwMTE0WhcNMzUwMzIxMTcw
MTE0WjBAMT4wPAYDVQQDDDVhNWExMDZhZS01MDVhLTRhOWEtYWJhMi1mOGI1Mjkw
OGI2ZmMgR0VOIDEgUHJvamVjdCBDQTCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCC
AYoCggGBAJ/C6CE5YIe+MKpSwxwC0wqmsu0fHgeksQA0KiPgr9vRtmRKEH1xfi7J
sPVDh6Bx4fACNS9QFz8gbqBnVcBPcO0k1rc4TR0L8s0lygZE2FaMMbTcWvzXqtTC
E0YgiWsOJg2vWcH4GfFbfTvLTtAAEzgQ/X9WgdXfSHfYZu7Lz3UuMSKOi90XRsIo
UaQA+04B6vmnJ3qr8VWzlkgIjeF4Npll326MDQZ81TPL/mXgMYgwK4M5r1o8YMi0
kFc5QW66L3u2BShu9X1hF8k77YGF18P/WSzxoz8nJbqhgWbeB6AJl/DoWRod5Ach
cDkhLIBCauSRDSX/snKYSuUY0daEBEUJzrpl6ap+KjEx35XWtk9gFaQrRP3HmwDY
PIMit+7neup87li8KXO+YwIsBLcbBiIyYpGoe+2+uO7/XCKWvGpJ1y4JuRBiTD+e
xeVXeE52cQjJwGIBOQo5VJGzQmnCddv2qTVQjf15hu4wLewYl53A89mmuNF+j5k7
RsWa7JYjcwIDAQABoz8wPTAdBgNVHQ4EFgQUGB+lA6HWHOkmst2+ubEzcJSk/yow
DwYDVR0TBAgwBgEB/wIBADALBgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQEMBQADggGB
AJAuMXzb/Yjt85wcBpPbv0nIVqR3QCgT4A3SB9JkhHArN7L8l6tEnTlQELb/HPMh
EhQPQJwxo7Y5Is7sQJyYkrJ8eOH+575QQbojkDVfrA8WG8xfEu7e8B/3ga0ZJvK5
PurNanL0ZFFEhiW1v5lwAJxBcfJ9PWszYVqcU0szR7e4/3cXbmYvAwSY5xCHptfm
u6nm+uNFFcYC5K0Gia6eGiXgwLp0NV9plpbCWhXR5ZVHd8Napua2xiDY8Vvx5F+J
NZkbQYbIUW+5WLhp493P0NhKhQeCoFiRw8qxCRx+IDoYKa0Tukvyix7ONA30eqf7
ygxMwaLcvBcVCUi7MbDizWFG+Xe5RY3FbBVQrs8CgasVUCfS40FKpu+XjlvGnhUz
DUa/L0EpXQAV68XUt607crbIVvWCSipO3EBwd8dnBVmPnx9N3w8PnG67Ex9eEArY
kPU0E77Z2SWDst5HH8Yvis1nu/hcEEPuQgS1tgJehTsDa1+h1oClk0J/4kje+50k
uQ==
-----END CERTIFICATE-----"  # MAYBE OVERWRITE

# Create the user secret in Kubernetes
kubectl create secret generic $USER_SECRET_NAME \
  --namespace=$NAMESPACE \
  --from-literal=SERVICE_NAME=$SERVICE_NAME \
  --from-literal=NODE_ENV=$NODE_ENV \
  --from-literal=PORT=$PORT \
  --from-literal=EMAIL_PASSWORD=$EMAIL_PASSWORD \
  --from-literal=EMAIL_FOR_SMTP=$EMAIL_FOR_SMTP \
  --from-literal=SMTP_HOST=$SMTP_HOST \
  --from-literal=SMTP_PORT=$SMTP_PORT \
  --from-literal=PROD_DOMAIN=$PROD_DOMAIN \
  --from-literal=TWILIO_ACCOUNT_SID=$TWILIO_ACCOUNT_SID \
  --from-literal=TWILIO_AUTH_TOKEN=$TWILIO_AUTH_TOKEN \
  --from-literal=TWILIO_PHONE_NUMBER=$TWILIO_PHONE_NUMBER \
  --from-literal=DB_USER=$DB_USER \
  --from-literal=DB_PASSWORD=$DB_PASSWORD \
  --from-literal=DB_HOST=$DB_HOST \
  --from-literal=DB_PORT=$DB_PORT \
  --from-literal=DB_NAME=$DB_NAME \
  --from-literal=DB_AIVEN_POSTGRES_CERT="$DB_AIVEN_POSTGRES_CERT" \
  --dry-run=client -o yaml | kubectl apply -f -
