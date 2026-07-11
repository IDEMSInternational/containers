#!/bin/bash

handle_shutdown() {
    echo "Shutdown signal received"
    kill -s SIGTERM $child
    wait $child
    exit 0
}

trap 'handle_shutdown' SIGQUIT

cat /opt/idems/config.php.template | envsubst "$(sed -e 's/^/$/' /opt/idems/config.php.vars)" > /var/www/html/config.php
echo "Configuration file (config.php) created"

while true
do
    php admin/cli/cron.php --keep-alive=59 &
    child=$!
    wait $child
done
