FROM postgis/postgis:16-3.4

# Include extra setup scripts (eg datastore)
COPY --chown=postgres:postgres docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
