#!/usr/bin/env bash

# This file gets run before we build our docker image

# if ! test -f "config/database.yml"; then
#   cp config/database.yml.example config/database.yml
# fi

# if ! test -f "config/secrets.yml"; then
#   cp config/secrets.yml.example config/secrets.yml
# fi

# if ! test -f "./.env"; then
#   cp ./.env.development.example ./.env

#   echo "Please enter the Sentry.io auth token:"
#   read -sp 'token: ' SENTRY_AUTH_TOKEN
#   echo "SENTRY_AUTH_TOKEN=\"$SENTRY_AUTH_TOKEN\"" >> ./.env
# fi
