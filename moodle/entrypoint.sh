#!/bin/bash

set -u

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
