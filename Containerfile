# SPDX-FileCopyrightText: 2025 Florian Wilhelm
#
# SPDX-License-Identifier: MIT

FROM docker.io/library/debian:trixie
ENV DEBIAN_FRONTEND=noninteractive

COPY debian-backports.sources /etc/apt/sources.list.d/debian-backports.sources

# Liberation is Writer's default face and the one grind bundles for its own layout. Without
# it, LibreOffice silently substitutes DejaVu, so line and page breaks measured here would be
# DejaVu's. Its own install, not part of the `-t trixie-backports` one, so it comes from
# trixie: Liberation 2.1.5, the version grind bundles.
RUN apt-get -qq update \
    && apt-get install --no-install-recommends -yqq fonts-liberation2 \
    && apt-get install -t trixie-backports --no-install-recommends -yqq \
        libreoffice-calc libreoffice-writer libreoffice-l10n-de jing \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
