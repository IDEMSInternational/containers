ARG MOODLE_VERSION=4.4.4
FROM docker.io/bitnami/moodle:$MOODLE_VERSION AS stager
RUN install_packages curl git
COPY plugins.* /staging/
RUN /staging/plugins.sh

FROM docker.io/bitnami/moodle:$MOODLE_VERSION
COPY --from=stager /opt/bitnami/moodle /opt/bitnami/moodle
