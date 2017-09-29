#!/bin/sh -x
printf "[indexer]\nurl = postgresql://${POSTGRESQL_USER}:${POSTGRESQL_PASSWORD}@${POSTGRESQL_SERVICE_HOST}:${POSTGRESQL_SERVICE_PORT}/${POSTGRESQL_DATABASE}\n" > /etc/gnocchi/gnocchi.conf
printf "[storage]\ncoordination_url = redis://:${REDIS_PASSWORD}@${REDIS_SERVICE_HOST}:${REDIS_SERVICE_PORT}\n" >> /etc/gnocchi/gnocchi.conf
printf "[incoming]\ndriver = redis\nredis_url = redis://:${REDIS_PASSWORD}@${REDIS_SERVICE_HOST}:${REDIS_SERVICE_PORT}\n" >> /etc/gnocchi/gnocchi.conf
printf "[statsd]\nresource_id = 0a8b55df-f90f-491c-8cb9-7cdecec6fc26\n" >> /etc/gnocchi/gnocchi.conf
gnocchi-upgrade || true
gnocchi-metricd &
gnocchi-statsd &
uwsgi /etc/gnocchi/uwsgi.ini
