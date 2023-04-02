#!/usr/bin/env bash
VARS_FILE=app/vars.yml
ENV_FILE=.env

docker image prune --force

if [ -f "${VARS_FILE}" ] && [ -f "${ENV_FILE}" ]; then
  echo "Found ${VARS_FILE} and ${ENV_FILE} conf files, building docker containers."
  docker compose build
  docker compose up --force-recreate -d ssl_domain_expiry_check
fi

if test -f "${VARS_FILE}"; then
  echo "${VARS_FILE} file exist, doing nothing."
else
  echo "${VARS_FILE} does not exist, creating $VARS_FILE file."
  cp app/vars.yml.example $VARS_FILE
fi

if test -f "${ENV_FILE}"; then
  echo "${ENV_FILE} file exist, doing nothing."
else
  echo "${ENV_FILE} does not exist, creating $ENV_FILE file."
  cp env.example $ENV_FILE
fi
