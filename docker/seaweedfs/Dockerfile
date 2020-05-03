FROM alpine:3.11

ARG VERSION=""

RUN apk update && apk add curl ca-certificates

COPY install-github-binary /usr/bin/install-github-binary
RUN install-github-binary ${VERSION} && rm /usr/bin/install-github-binary

USER 10001:10001

ENTRYPOINT [ "weed" ]
