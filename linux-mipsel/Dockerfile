FROM dockcross/base:latest
MAINTAINER Sergi Alvarez "pancake@nopcode.org"

# This is for ARMv5 "legacy" (mipsel) devices which do NOT support hard float
# VFP instructions (mipshf).

# From https://wiki.debian.org/CrossToolchains, installing for jessie
RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/emdebian.list \
&& curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add - \
&& sed -i 's/httpredir.debian.org/http.debian.net/' /etc/apt/sources.list \
&& dpkg --add-architecture mipsel \
&& apt-get update && apt-get install -y crossbuild-essential-mipsel

# The cross-compiling emulator
RUN apt-get update && apt-get install -y \
  qemu-user \
  qemu-user-static

ENV CROSS_TRIPLE mipsel-linux-gnu
ENV CROSS_ROOT /usr/bin
ENV AS=${CROSS_ROOT}/${CROSS_TRIPLE}-as \
    AR=${CROSS_ROOT}/${CROSS_TRIPLE}-ar \
    CC=${CROSS_ROOT}/${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_ROOT}/${CROSS_TRIPLE}-cpp-4.9 \
    CXX=${CROSS_ROOT}/${CROSS_TRIPLE}-g++ \
    LD=${CROSS_ROOT}/${CROSS_TRIPLE}-ld \
    FC=${CROSS_ROOT}/${CROSS_TRIPLE}-gfortran

ENV QEMU_LD_PREFIX ${CROSS_ROOT}/libc
ENV QEMU_SET_ENV "LD_LIBRARY_PATH=${CROSS_ROOT}/lib:${CROSS_ROOT}/libc/lib/${CROSS_TRIPLE}/"

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/linux-mipsel

COPY Toolchain.cmake ${CROSS_ROOT}/
ENV CMAKE_TOOLCHAIN_FILE ${CROSS_ROOT}/Toolchain.cmake

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
