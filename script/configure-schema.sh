#!/bin/bash

USAGE="\n
  Usage:\n
    configure-schema [production|dev|test]\n
\n
This script:\n
- Creates a user for the site\n
- Creates a schema for the site\n
- Sets the search path for the user to '<schema>, public'\n
- Grants SELECT permissions on all public tables to the user\n
- Grans permissions for shared tables\n
\t- See the script source for table permissions granted\n
"

NAME='r24e'

if [[ $1 == "" || $1 == "-h" || $1 == "--help" ]]; then
echo $USAGE
  exit 0
elif [[ $1 == "production" ]]; then
  DATABASE="r24e_production"
  HOST="localhost"
elif [[ $1 == "dev" ]]; then
  DATABASE="r24e_development"
  HOST="localhost"
elif [[ $1 == "test" ]]; then
  DATABASE="r24e_test"
  HOST="localhost"
else
  DATABASE="ff_dev"
  HOST="localhost"
fi

# create user
createuser --host=${HOST} -U postgres -D -R -S ${NAME}

# create schema
psql ${DATABASE} -U postgres --host=${HOST} -c "CREATE SCHEMA ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON SCHEMA ${NAME} to ${NAME}"

# set search path for the user so we can say "select * from [users|roles|healthplan|drug|etc..]" and it knows where to look
psql ${DATABASE} -U postgres --host=${HOST} -c "ALTER USER ${NAME} SET search_path TO ${NAME},public"

# site user can SELECT from all public tables
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT SELECT ON all tables in schema public to ${NAME}"

# grant special permissions for shared modifyable tables
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON SCHEMA public TO ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO ${NAME}"

psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON SCHEMA ${NAME} TO ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA ${NAME} TO ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON ALL TABLES IN SCHEMA ${NAME} TO ${NAME}"

psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON SCHEMA ${NAME} TO ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA ${NAME} TO ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "GRANT ALL ON ALL TABLES IN SCHEMA ${NAME} TO ${NAME}"

psql ${DATABASE} -U postgres --host=${HOST} -c "ALTER DEFAULT PRIVILEGES IN SCHEMA ${NAME} GRANT ALL ON TABLES TO ${NAME}"
psql ${DATABASE} -U postgres --host=${HOST} -c "ALTER DEFAULT PRIVILEGES IN SCHEMA ${NAME} GRANT ALL ON SEQUENCES TO ${NAME}"
