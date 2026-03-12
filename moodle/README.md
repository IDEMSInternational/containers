# Moodle container

The purpose of this project is to create a container image for Moodle that is capable of operating at large scale.

# Requirements

- Docker
- Docker Compose

# Quick start

Start all services.
```
docker compose up -d
```

In a web browser, navigate to <https://localhost/>. Any security complaints from the browser can safely be ignored or excepted.

# View outgoing emails

[Mailpit] has been set up to catch all outgoing emails from Moodle. View sent emails via the web UI at <http://localhost:8025/>.

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

Remove the 'moodle_base' volume.
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


[Mailpit]: https://github.com/axllent/mailpit
[STACK settings page]: https://localhost/admin/settings.php?section=qtypesettingstack
