#!/bin/bash

# Test connectity indefinitely while with SQL Server starting
function wait-sqlservr() {
  MSSQL_QUERY="IF DB_ID('$MSSQL_DBNAME') IS NULL print '0' ELSE print '1'"

  while [[ "$DB_EXISTS" != '1' ]] && [[ "$DB_EXISTS" != '0' ]]; do
    # Run SQL script testing ${MSSQL_DBNAME} existing
    DB_EXISTS=$("$MSSQL_TOOLS_PATH"/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -Q "$MSSQL_QUERY" 2>/dev/null)
  done

  echo $DB_EXISTS
}
export -f wait-sqlservr

# Wait wait-sqlservr execution during $1 else 1m maximum
if [[ $1 ]]; then
  timeout $1 bash -c wait-sqlservr
else
  timeout 30s bash -c wait-sqlservr
fi

exit
