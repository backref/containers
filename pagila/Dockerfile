FROM postgres:15-alpine AS preseed

# "trust" should never be used in a production setting, but should
# be safe enough for a sample database
ENV POSTGRES_USER postgres
ENV POSTGRES_DB pagila
ENV POSTGRES_PASSWORD password

COPY pagila-data-apt-jsonb.sql /pagila-data-apt-jsonb.sql
COPY pagila-data-yum-jsonb.sql /pagila-data-yum-jsonb.sql

COPY pagila-schema.sql /docker-entrypoint-initdb.d/1_schema.sql
COPY pagila-data.sql /docker-entrypoint-initdb.d/2_data.sql
COPY pagila-schema-jsonb.sql /docker-entrypoint-initdb.d/3_schema_jsonb.sql
COPY restore-jsonb.sh /docker-entrypoint-initdb.d/4_restore_jsonb_data.sh

# - Slightly modify built-in docker-entrypoint.sh to not exec after scripts
# - Ensure sh scripts are executable
# - Finally, run docker-entrypoint.sh script to run all our scripts
RUN grep -v 'exec "$@"' /usr/local/bin/docker-entrypoint.sh > /docker-entrypoint.sh \
  && chmod 755 /docker-entrypoint.sh \
  && chmod 755 /docker-entrypoint-initdb.d/4_restore_jsonb_data.sh \
  && /docker-entrypoint.sh postgres 

### Copy just the pre-seeded PGDATA directory to new image
FROM postgres:15-alpine
COPY --from=preseed /var/lib/postgresql/data /var/lib/postgresql/data
