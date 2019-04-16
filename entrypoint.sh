#!/usr/bin/env sh

set -o errexit
set -o nounset

cmd="$*"

# Client spec:
SQL="/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD""

# Start mssql server in the background:
/opt/mssql/bin/sqlservr &

mssql_ready () {
  sh '/code/wait-for-command.sh' -s 0 -c "$SQL"
}

until mssql_ready; do
  >&2 echo 'MSSQL is unavailable - sleeping'
  sleep 1
done

echo '======= MSSQL SERVER STARTED ========'
# Run the setup script to create the DB and the schema in the DB:
$SQL -d master -i /code/scripts/schema.sql
$SQL -d master -i /code/scripts/data.sql
echo '======= MSSQL CONFIG COMPLETE ======='

# Evaluating passed command:
exec $cmd
