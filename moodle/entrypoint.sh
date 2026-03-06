#!/bin/bash

set -eu

tar -C /var/www/html -xf /opt/idems/moodle.tar.gz
chown -R www-data:www-data /var/www
echo "Moodle source files installed"

cat /opt/idems/config.php.template | envsubst '$MOODLE_DB_TYPE $MOODLE_DB_HOST $MOODLE_DB_PORT_NUMBER $MOODLE_DB_USER $MOODLE_DB_NAME $MOODLE_DB_PASS $MOODLE_REVERSE_PROXY $MOODLE_SMTP_HOST $MOODLE_SMTP_PORT $MOODLE_SMTP_USER $MOODLE_SMTP_PASSWORD $MOODLE_WWW_ROOT $MOODLE_ADMIN_USER $MOODLE_ADMIN_PASS $MOODLE_ADMIN_EMAIL $MOODLE_FULL_NAME $MOODLE_SHORT_NAME $MOODLE_SUPPORT_EMAIL' > /var/www/html/config.php
echo "Configuration file (config.php) created"

set +e
php admin/cli/install_database.php --agree-license --adminuser=${MOODLE_ADMIN_USER} --adminpass=${MOODLE_ADMIN_PASS} --adminemail=${MOODLE_ADMIN_EMAIL} --fullname="${MOODLE_FULL_NAME}" --shortname="${MOODLE_SHORT_NAME}" --supportemail=${MOODLE_SUPPORT_EMAIL}
set -e
echo "Database setup completed"

echo "Running Moodle..."
exec "$@"
