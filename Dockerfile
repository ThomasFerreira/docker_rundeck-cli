FROM openjdk:8-jre-slim

MAINTAINER Thomas Ferreira <thomas.ferreira+docker@_n0spam_protonmail.com>

ARG _RD_CLI_VERSION_="1.0.25"
ARG _RD_CLI_DEB_CHECKSUM_="31c0029330214819184c0248ffe16a04696db4050e5d607e552988dab08cdbcdc0371903aa5ac0c74f262a65d7cf1f6992493749af8317a284d94629d606c505"

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
