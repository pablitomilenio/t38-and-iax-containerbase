# Set the base image to Ubuntu 18.04, which is compatible with the legacy fax packages that come precompiled
FROM ubuntu:bionic

# Port exposures
EXPOSE 5060/udp
EXPOSE 5060/tcp
EXPOSE 6060/udp
EXPOSE 6060/tcp

# Info: please name this image: "FOIP-containerbase" for further use in docker" for further use in compose

# Update the repository sources list and install CAPI (As a small addition to the container functionalities)
# RUN apt-get install -y capiutils libcapi20-3 git wget

# Update to the latest packages list (mandatory, if not it will not know iaxmodem)
RUN apt-get update && apt-get install git wget inetutils-ping nano -y

# Install IAX Modem
RUN apt-get install iaxmodem -y

# Install T.38 Modem
RUN apt-get install t38modem -y

# Install The Asterix Phone Central
RUN DEBIAN_FRONTEND=noninteractive apt-get install asterisk -y

# Install HylaFax
RUN DEBIAN_FRONTEND=noninteractive apt-get install hylafax-server -y 

# Copy configuration files
COPY initial-configuration-files/etc-asterisk/* /etc/asterisk
COPY initial-configuration-files/iaxmodem/* /etc/iaxmodem

# Run initial config
CMD sh initial-setup.sh


