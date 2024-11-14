FROM docker.io/bitnami/moodle:4.3.8 AS stager
RUN install_packages curl git
COPY plugins.* /staging/
RUN /staging/plugins.sh

FROM docker.io/bitnami/moodle:4.3.8
COPY --from=stager /opt/bitnami/moodle /opt/bitnami/moodle
