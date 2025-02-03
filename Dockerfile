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
