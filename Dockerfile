FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes --no-install-recommends build-essential linux-headers-generic avahi-utils alsa-utils && \
    rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true

WORKDIR /app

COPY sounds/ ./sounds/
COPY script/setup ./script/
COPY setup.py requirements*.txt MANIFEST.in ./
COPY wyoming_satellite/ ./wyoming_satellite/
COPY pixel_ring/ ./pixel_ring/

RUN script/setup --aen --vad --led

RUN apt-get purge --yes build-essential linux-headers-generic && \
    apt-get autoremove --purge --yes

COPY script/run ./script/
COPY docker/run ./

EXPOSE 10700

ENTRYPOINT ["/app/run"]
