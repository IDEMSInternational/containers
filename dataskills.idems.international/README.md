# Moodle container for dataskills.idems.international

The purpose of this project is to develop a Moodle container image that will be deployed to [dataskills.idems.international].

# Requirements

- Docker
- Docker Compose

[Docker Desktop] contains both of the components above and may be more convenient for Windows users.

# Quick start

Start all services.

```
docker compose up -d
```

In a web browser, navigate to <http://localhost:8080/>. To login as admin use:
- username: user
- password: bitnami

View the logs.

```
docker compose logs -f
```

# View outgoing emails

[Mailpit] has been set up to catch all outgoing emails from Moodle. View sent emails via the web UI at <http://localhost:8025/>.

# Access to Moodle filesystem

On startup, the Moodle container checks whether an existing Moodle installation exists. If not, the container will install the Moodle code at `/bitnami/moodle` within the container. This directory is mapped to `./moodlefs/moodle` on the host, so that there is a way to directly access the running Moodle code.


[Mailpit]: https://github.com/axllent/mailpit
[dataskills.idems.international]: https://dataskills.idems.international/
[Docker Desktop]: https://www.docker.com/products/docker-desktop/
