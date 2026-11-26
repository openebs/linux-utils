# Minimal shell image for OpenEBS helper and init containers, on Red Hat UBI.
#
# ubi-micro already ships bash, coreutils-single (timeout, sleep, date, chown)
# and ncurses, which is everything the helper and probe commands use, so no
# package is installed here and the image needs no package manager.
#
# bash is the reason this is the micro image rather than a scratch one: its
# /dev/tcp redirection replaces netcat for the readiness probes, so nothing
# extra has to be installed to check that a dependency is listening.
# There is deliberately no FIPS configuration here. ubi-micro ships no crypto
# at all - no libcrypto, no libssl, no gnutls, no nss, no openssl binary - and
# the probes speak plain TCP, never TLS. Installing openssl-fips-provider would
# add a crypto stack, and its CVE surface, for code that nothing in this image
# calls. On a FIPS-enabled host the kernel is in FIPS mode regardless.
FROM registry.access.redhat.com/ubi9/ubi-micro:9.9

ARG DBUILD_DATE
ARG DBUILD_REPO_URL="https://github.com/openebs/linux-utils"
ARG DBUILD_SITE_URL="https://www.openebs.io/"

COPY LICENSE /licenses/LICENSE

# Red Hat's own labels describe ubi-micro; restate them for this image.
LABEL name="openebs/ubi-bash" \
      vendor="OpenEBS" \
      maintainer="OpenEBS Maintainers" \
      summary="Minimal shell container for OpenEBS helper jobs" \
      description="Provides bash, timeout, sleep, date and chown for OpenEBS helper and init containers."

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="linux-utils"
LABEL org.label-schema.description="Linux Container for OpenEBS Helper jobs"
LABEL org.label-schema.build-date=$DBUILD_DATE
LABEL org.label-schema.vcs-url=$DBUILD_REPO_URL
LABEL org.label-schema.url=$DBUILD_SITE_URL
