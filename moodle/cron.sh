#!/bin/bash

handle_shutdown() {
    echo "Shutdown signal received"
    kill -s SIGTERM $child
    wait $child
    exit 0
}

trap 'handle_shutdown' SIGQUIT

while true
do
    php admin/cli/cron.php --keep-alive=59 &
    child=$!
    wait $child
done
