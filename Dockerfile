FROM openjdk:8-jre-slim

MAINTAINER Thomas Ferreira <thomas.ferreira+docker@_n0spam_protonmail.com>

ARG _RD_CLI_VERSION_="1.0.17"
ARG _RD_CLI_DEB_CHECKSUM_="9e5d966340bfaf616fd5ae94d4c39361541bb1c7adb5c1ddecb9a9b45c0e5c71ab1e718c5b221dd42e5acb3e548d75f264dfced30e8e53c7fdb920fb7ef8c0b3"

RUN apt-get update \
  && apt-get install -y curl \
  && curl -Lo /tmp/rundeck-cli.deb https://github.com/rundeck/rundeck-cli/releases/download/v${_RD_CLI_VERSION_}/rundeck-cli_${_RD_CLI_VERSION_}-1_all.deb \
  && echo "${_RD_CLI_DEB_CHECKSUM_}  /tmp/rundeck-cli.deb" > /tmp/rundeck-cli.sig \
  && sha512sum -c /tmp/rundeck-cli.sig \
  && dpkg -i /tmp/rundeck*.deb \
  && rm /tmp/rundeck*.deb /tmp/rundeck-cli.sig\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV RD_AUTH_PROMPT false

ENTRYPOINT ["/usr/bin/rd"]
CMD ["--help"]