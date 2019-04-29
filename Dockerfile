FROM openjdk:8-jre-slim

MAINTAINER Thomas Ferreira <thomas.ferreira+docker@_n0spam_protonmail.com>

ARG _RD_CLI_VERSION_="1.1.2"
ARG _RD_CLI_DEB_CHECKSUM_="1cde7b93f5eaa354110c77171a8656c948c41bc23b8468620216262ff77d19a7a5878c45d0a99fe47584c376eb4d52fb81870babaf48489ce5faf998448f7907"

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
