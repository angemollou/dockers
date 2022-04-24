FROM mcr.microsoft.com/mssql/server:2017-latest
MAINTAINER Ange M. <angemollou@outlook.com>

# Set required variable to start SQL Server
ENV MSSQL_TOOLS_PATH=/opt/mssql-tools/bin/
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=yourStrong(!)Password
ENV MSSQL_DBNAME=openimis

# Install curl
RUN apt-get -y update  && \
  apt-get install -y curl

# Fetch openIMIS_ONLINE.sql to init ${MSSQL_DBNAME}
RUN curl -sLO https://github.com/openimis/database_ms_sqlserver/raw/main/Empty%20databases/openIMIS_ONLINE.sql

# Server is listening on [ 'any' <ipv6> 1433].
# Server is listening on [ 'any' <ipv4> 1433].
# Server is listening on [ ::1 <ipv6> 1434].
# Server is listening on [ 127.0.0.1 <ipv4> 1434].
# Dedicated admin connection support was established for listening locally on port 1434
# Expose SQL Server default port
EXPOSE 1433 1434

# Copy scripts and set permission for execution to current user only
COPY ./entrypoint.sh /
COPY ./wait-mssql-for.sh /
RUN chmod a+x /entrypoint.sh /wait-mssql-for.sh

ENTRYPOINT [ "/entrypoint.sh" ]