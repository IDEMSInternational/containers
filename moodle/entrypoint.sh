#!/bin/bash

set -eu

if [[ ! $(ls -A /var/www/html) ]]
then
    tar -C /var/www/html -xf /opt/idems/moodle.tar.gz
    chown -R www-data:www-data /var/www
    echo "Moodle source files installed"
fi

cat /opt/idems/config.php.template | envsubst "$(sed -e 's/^/$/' /opt/idems/config.php.vars)" > /var/www/html/config.php
echo "Configuration file (config.php) created"

set +e
php admin/cli/install_database.php \
    --agree-license \
    --adminuser=${MOODLE_ADMIN_USER} \
    --adminpass=${MOODLE_ADMIN_PASS} \
    --adminemail=${MOODLE_ADMIN_EMAIL} \
    --fullname="${MOODLE_FULL_NAME}" \
    --shortname="${MOODLE_SHORT_NAME}" \
    --supportemail=${MOODLE_SUPPORT_EMAIL}
set -e
echo "Database setup completed"

echo "Running command: $@"
exec "$@"
