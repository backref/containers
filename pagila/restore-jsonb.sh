#!/bin/sh

pg_restore /pagila-data-yum-jsonb.sql -U postgres -d pagila &&
    pg_restore /pagila-data-apt-jsonb.sql -U postgres -d pagila
