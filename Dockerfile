FROM debian:bookworm

ARG INSTALLER_URL=https://download.agiloft.com/binary/Agiloft-Release_28-28792-linux-64bit-setup.sh
ARG INSTALLER_MD5=002efd82e52f0c9c33b9b4cdc7b91004

ENV container docker
ENV DEBIAN_FRONTEND noninteractive

# Install required packages/libs for Agiloft and systemd
RUN apt-get update && apt-get install -y \
    libaio1 \
    libnss3 \
    libncurses5 \
    libnuma1 \
    libtinfo5 \
    libfontconfig1 \
    openssl \
    curl \
    iproute2 \
    xz-utils \
    procps \
    lsof \
    net-tools \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download installer
ADD ${INSTALLER_URL} installer.sh

# Verify installer checksum and run installer
RUN echo "${INSTALLER_MD5}  installer.sh" | md5sum -c && \
    chmod +x installer.sh && \
    ./installer.sh --unattended && \
    rm installer.sh

EXPOSE 80/tcp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
