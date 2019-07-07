#! /usr/bin/env bash

echo "Running inside /app/prestart.sh, you could add migrations to this file, e.g.:"

cp /app/supervisor-restart-uwsgi.conf /etc/supervisor/conf.d/

echo "
#! /usr/bin/env bash

# Let the DB start
sleep 10;
# Run migrations
alembic upgrade head
"
