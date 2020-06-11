FROM openjdk:8-jre-slim

MAINTAINER Thomas Ferreira <thomas.ferreira+docker@_n0spam_protonmail.com>

ARG _RD_CLI_VERSION_="1.3.0"
ARG _RD_CLI_DEB_CHECKSUM_="82574c22fbc17c58cf3fa7a3ed26784d0e1c24885049fccdfd9e36324cd0853bb38fa4daf4d6e201c3f45a90d1207217a8dd9c56d7acd91cd07bf8653e0adfab"

RUN apt-get update \
  && apt-get install -y curl \
  && curl -Lo /tmp/rundeck-cli.deb https://dl.bintray.com/rundeck/rundeck-deb/rundeck-cli_${_RD_CLI_VERSION_}-1_all.deb \
  && echo "${_RD_CLI_DEB_CHECKSUM_}  /tmp/rundeck-cli.deb" > /tmp/rundeck-cli.sig \
  && sha512sum -c /tmp/rundeck-cli.sig \
  && dpkg -i /tmp/rundeck*.deb \
  && rm /tmp/rundeck*.deb /tmp/rundeck-cli.sig\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV RD_AUTH_PROMPT false

ENTRYPOINT ["/usr/bin/rd"]
CMD ["--help"]
