FROM openjdk:8-jre-slim

MAINTAINER Thomas Ferreira <thomas.ferreira+docker@_n0spam_protonmail.com>

ARG _RD_CLI_VERSION_="1.0.24"
ARG _RD_CLI_DEB_CHECKSUM_="5cacd9c1326d48729ddf5076519346b915c7758953b134cd64a347313635a71e090ffcd4f375b3011d497a80fc7398e6768465279021314f69e25fb79e20b174"

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
