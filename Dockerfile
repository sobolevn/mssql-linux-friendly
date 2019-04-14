FROM mcr.microsoft.com/mssql/server:2017-CU12-ubuntu
# Source: https://github.com/Microsoft/mssql-docker/

# This is a special case. We need to run this script as an entry point:
COPY ./entrypoint.sh /docker-entrypoint.sh

# Making files executable:
RUN chmod +x "/docker-entrypoint.sh"

# Copy our startup files to the image:
WORKDIR /code
COPY . /code/

# Creates tables and inserts data, if needed:
ENTRYPOINT ["/docker-entrypoint.sh"]

# We need something to run forever, since we start `mssql` in the background:
CMD ["sleep infinity"]
