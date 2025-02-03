FROM <registry>/<path>/telegraf-tns:1.0

# Umgebungsvariablen für non-interactive Modus
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN echo "deb http://deb.debian.org/debian bookworm main contrib" > /etc/apt/sources.list && \
    apt update && \
    apt install -y smartmontools nvme-cli zfsutils-linux
# RUN echo "Defaults:telegraf \!requiretty, \!syslog" >> /etc/sudoers

# Konfigurationsdatei kopieren
# COPY telegraf.conf /etc/telegraf/telegraf.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Benutzer wechseln
#USER telegraf
#Standard-Befehl
CMD ["telegraf"]

# # Standardbefehl
# CMD ["/bin/bash"]











# FROM debian:bookworm

# ENV DEBIAN_FRONTEND=noninteractive
# ENV TZ=Europe/Berlin

# # Grundlegende Abhängigkeiten installieren
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     curl \
#     gnupg \
#     lsb-release && \
#     apt-get clean

# # InfluxData GPG-Schlüssel manuell herunterladen und hinzufügen
# RUN curl -fsSL https://repos.influxdata.com/influxdata-archive_compat.key | gpg --dearmor -o /usr/share/keyrings/influxdata-archive_compat.gpg

# # InfluxData-Repository hinzufügen
# RUN echo "deb [signed-by=/usr/share/keyrings/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/influxdata.list

# # Telegraf installieren
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends telegraf && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# FROM docker.io/telegraf:1.33-alpine

# RUN apk add bash sudo smartmontools nvme-cli

# # Arbeitsverzeichnis
# WORKDIR /app

# # Standardbefehl
# # CMD ["telegraf"]
# CMD ["/bin/bash"]



# FROM docker.io/telegraf:1.27.2

# # Umgebungsvariablen für non-interactive Modus
# ENV DEBIAN_FRONTEND=noninteractive
# ENV TZ=Europe/Berlin

# # ZFS-Tools installieren
# # Universe-Repository manuell hinzufügen und ZFS-Tools installieren
# RUN apt-get update && \
#     echo "deb http://archive.ubuntu.com/ubuntu focal main universe" > /etc/apt/sources.list.d/universe.list && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends \
#     zfsutils-linux && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # RUN echo "Defaults:telegraf \!requiretty, \!syslog" >> /etc/sudoers

# # Standardbefehl
# CMD ["/bin/bash"]