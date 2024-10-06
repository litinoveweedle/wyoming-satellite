FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

COPY sounds/ ./sounds/
COPY script/setup ./script/
COPY script/run* ./script/
COPY examples/*_service.py ./examples/
COPY wyoming_satellite/ ./wyoming_satellite/
COPY setup.py requirements*.txt MANIFEST.in ./

COPY docker/run ./

RUN apt-get update && \
    apt-get install --yes --no-install-recommends vim-tiny build-essential linux-headers-generic libusb-1.0 avahi-utils alsa-utils && \
    script/setup --aen --vad --led && \
    apt-get remove --purge --yes build-essential linux-headers-generic && \
    apt-get autoremove --purge --yes && \
    rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true

EXPOSE 10700

ENTRYPOINT ["/app/run"]
