# Preparation

## Creating the new base image with Debian

- cd into the path of the custom base image Dockerfile (`influxdata-docker/telegraf/1.33-custom`) 
- Copy the `Dockerfile` and the `entrypoint.sh` from the telegraf folder (e.g.: `telegraf/1.33`) out of the influxdata-docker Github repository (if you need a new one). I added them here under `influxdata-docker/telegraf/1.33-custom` with my changes.  
- Change the Dockerfile and add these changes: 

```Dockerfile
FROM debian:bookworm

# ...

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends bash dirmngr gpg gpg-agent iputils-ping snmp procps lm-sensors libcap2-bin wget && \
    rm -rf /var/lib/apt/lists/*

# set default shell to Bash
SHELL ["/bin/bash", "-c"]

# ...

ENV TELEGRAF_VERSION=1.33.1

# ...
# Remove Cert Check to prevent errors
# Wasnt able to fix it without it
wget --no-check-certificate --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb.asc && \
wget --no-check-certificate --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb && \

# ...
```

- Tag and Push the image to your docker registry: `docker build -f Dockerfile . -t <registry>/<path>/telegraf-tns:1.0` && `docker push <registry>/<path>/telegraf-tns:1.0`


## Build the image based on the new debian base image 

After the base image was created it is possible to create the telegraf image with the needed tools. 

- cd into the root of this repo and build the image for the custom telegraf container with zfs-tools 
- Build and push it: `docker build -f Dockerfile . -t <registry>/<path>/telegraf-tns-zfs:1.2` && `docker push <registry>/<path>/telegraf-tns-zfs:1.2`
- Add the content from the container.yaml in TrueNAS under `Apps` > `Discover Apps` > `Install YAML` - Dont forget to change it to your environment (hdd)!

## Influx

- Create the bucket if needed and check if data comes in. 



# Links 
- https://github.com/influxdata/influxdata-docker/tree/master/telegraf
- https://github.com/influxdata/influxdata-docker/blob/master/telegraf/1.33/Dockerfile
- https://github.com/influxdata/influxdata-docker/blob/master/telegraf/1.33/entrypoint.sh 