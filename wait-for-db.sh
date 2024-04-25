#!/bin/bash
# Script to wait for the database to be available

set -e

host="$1"
port="$2"
shift
shift
cmd="$@"

until mysqladmin ping -h "$host" -P "$port" --silent; do
  >&2 echo "Database is unavailable - sleeping"
  sleep 1
done

>&2 echo "Database is up - executing command"
exec $cmd
