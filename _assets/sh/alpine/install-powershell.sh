#!/bin/sh

PowerShellVersion=7.3.6
PowerShellPackage=powershell-${PowerShellVersion}-linux-alpine-x64.tar.gz
PowerShellDownloadURL=https://github.com/PowerShell/PowerShell/releases/download/v${PowerShellVersion}/${PowerShellPackage}

apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl \
    && apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust

wget ${PowerShellDownloadURL} -O /tmp/powershell.tar.gz

mkdir -p /opt/microsoft/powershell/7 \
    && tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 \
    && chmod +x /opt/microsoft/powershell/7/pwsh \
    && rm /usr/bin/pwsh \
    && ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh \
    && rm /tmp/powershell.tar.gz
