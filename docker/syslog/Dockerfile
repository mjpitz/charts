FROM alpine:3

ARG VERSION=3.27.1-r0

RUN apk update
  RUN apk add ca-certificates syslog-ng syslog-ng-scl syslog-ng-dev

ENTRYPOINT [ "/usr/sbin/syslog-ng", "-F" ]
