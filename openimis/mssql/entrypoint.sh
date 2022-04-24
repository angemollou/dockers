#!/bin/bash

# Exit on sub-process exiting with non-zero status
set -e

# Start SQL Server
/opt/mssql/bin/sqlservr &

# Wait for SQL Server starting during 30s
DB_EXISTS=$(/wait-mssql-for.sh 45s)

# create and init ${MSSQL_DBNAME}
if [[ "$DB_EXISTS" == '0' ]]; then
  echo "Create/initialize $MSSQL_DBNAME database"

  "$MSSQL_TOOLS_PATH"/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -Q "CREATE DATABASE [$MSSQL_DBNAME]" &&
    "$MSSQL_TOOLS_PATH"/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d "$MSSQL_DBNAME" -i /openIMIS_ONLINE.sql

  echo
  echo "$MSSQL_DBNAME database is initialized"
  echo 'Please, restart the container'
elif [[ "$DB_EXISTS" == '1' ]]; then
  sleep infinity
fi

exit
