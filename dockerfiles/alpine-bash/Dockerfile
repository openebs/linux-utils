FROM alpine:3.23.3

RUN apk add --no-cache bash

ARG DBUILD_DATE
ARG DBUILD_REPO_URL="https://github.com/openebs/linux-utils"
ARG DBUILD_SITE_URL="https://www.openebs.io/"

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="linux-utils"
LABEL org.label-schema.description="Linux Container for OpenEBS Helper jobs"
LABEL org.label-schema.build-date=$DBUILD_DATE
LABEL org.label-schema.vcs-url=$DBUILD_REPO_URL
LABEL org.label-schema.url=$DBUILD_SITE_URL
