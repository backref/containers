FROM postgres:15-alpine AS preseed

# "trust" should never be used in a production setting, but should
# be safe enough for this example
ENV POSTGRES_HOST_AUTH_METHOD trust
ENV POSTGRES_DB chinook
ENV POSTGRES_USER user123
ENV POSTGRES_PASSWORD password123

COPY Chinook_PostgreSql_SerialPKs_CaseInsensitive.sql /docker-entrypoint-initdb.d/01.sql

RUN grep -v 'exec "$@"' /usr/local/bin/docker-entrypoint.sh > /docker-entrypoint.sh \
  && chmod 755 /docker-entrypoint.sh 

# Run Postgres, it will stop after the .sql files have been installed into the database
RUN /docker-entrypoint.sh postgres

### Copy just the pre-seeded PGDATA directory to new image
FROM postgres:15-alpine
COPY --from=preseed /var/lib/postgresql/data /var/lib/postgresql/data
