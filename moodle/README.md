# Moodle container

The purpose of this project is to create a container image for Moodle that is capable of operating at large scale.

# Requirements

- Docker
- Docker Compose

# Installation

Start up the 'moodle' service.
```
docker compose up -d moodle
```

Check the logs for the message "Installation completed successfully".
```
docker compose logs -f moodle
```

Once installed, start up the remaining services.
```
docker compose up -d
```

In a web browser, navigate to <https://localhost/admin/>. Any security complaints from the browser can safely be ignored or excepted. Complete any post-installation setup - it should be fine to simply click the "Save" button at the bottom of the page. At this point, the installation should be complete.

# Email notifications

Visit the outgoing mail configuration page: <https://localhost/admin/settings.php?section=outgoingmailconfig>.

Configure:

- SMTP hosts: mail:1025
- SMTP username: moodle
- SMTP password: moodle
- No-reply address: no-reply@example.com

Send a test email: <https://localhost/admin/testoutgoingmailconf.php>.

[Mailpit] should catch all outgoing emails from Moodle. View sent emails via the web UI at <http://localhost:8025/>.

# Configuring STACK

Some manual configuration is required to set up the Computer Algebra System (CAS) connection from STACK to Goemaxima. Visit the STACK settings page: <https://localhost/admin/settings.php?section=qtypesettingstack>.

Set the following:

- Platform type: Server
- Maxima version: 5.44.0
- URL of the Maxima Pool: http://maxima:8080/maxima

# Upgrading

Make sure all services are stopped.
```
docker compose down
```

Remove the 'moodle\_base' volume.
```
docker volume rm moodle_moodle_base
```

Start the 'moodle' service.
```
docker compose up -d moodle
```

Complete any post-upgrade setup. In a web browser, navigate to <https://localhost/admin/>.

Start up the remaining services.
```
docker compose up -d
```

# PHP configuration via environment variables

A few PHP settings can be altered via environment variables of the 'moodle' service:

- `PHP_MAX_INPUT_VARS`: limits the number of values that can be submitted from input forms; for Moodle, a value greater than or equal to 5000 is recommended; default "5000"
- `PHP_POST_MAX_SIZE`: limits the number of bytes that can be received in a single POST request; default "8M"
- `PHP_UPLOAD_MAX_FILESIZE` limits the file size that can be uploaded in a single request; default "8M"


[Mailpit]: https://github.com/axllent/mailpit
[STACK settings page]: https://localhost/admin/settings.php?section=qtypesettingstack
[max_input_vars]: https://www.php.net/manual/en/info.configuration.php#ini.max-input-vars
