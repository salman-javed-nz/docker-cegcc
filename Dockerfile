#
# Dockerfile for creating a Windows CE build environment using https://github.com/salman-javed-nz/cegcc-build
# Copyright (c) 2024 Colin Finck, ENLYZE GmbH <c.finck@enlyze.com>
# SPDX-License-Identifier: MIT
#

FROM debian:12-slim
MAINTAINER Salman Javed <mail@salmanjaved.org>
LABEL Description="Debian with CeGCC 14.2.0 (for ${target_arch}) and Git"

ARG target_arch

ENV PATH=/opt/cegcc-${target_arch}/bin:$PATH

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends bison build-essential ca-certificates flex git libgmp-dev libmpc-dev libmpfr-dev texinfo

RUN git clone --depth 1 --recursive --shallow-submodules https://github.com/salman-javed-nz/cegcc-build && \
    cd cegcc-build && \
    ./build_cf.sh /opt/cegcc-${target_arch} ${target_arch}-mingw32ce && \
    cd .. && \
    rm -rf cegcc-build
