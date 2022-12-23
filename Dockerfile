# Set the base image to Ubuntu 18.04, which is compatible with the legacy fax packages that come precompiled
FROM ubuntu:bionic

# Port exposures
EXPOSE 3000/udp
EXPOSE 3000/tcp
EXPOSE 5060/udp
EXPOSE 5060/tcp
EXPOSE 5061/udp
EXPOSE 5061/tcp
EXPOSE 6060/udp
EXPOSE 6060/tcp
EXPOSE 30000-30100:30000-30100/tcp
EXPOSE 30000-30100:30000-30100/udp

# Info: please name this image: "FOIP-containerbase" for further use in docker" for further use in compose

# Update the repository sources list and install CAPI (As a small addition to the container functionalities)
# RUN apt-get install -y capiutils libcapi20-3 git wget

# Update to the latest packages list (mandatory, if not it will not know iaxmodem)
RUN apt-get update && apt-get install git wget inetutils-ping nano -y

# Install IAX Modem
RUN apt-get install iaxmodem -y

# Install T.38 Modem
# RUN apt-get install t38modem -y

# Install The Asterix Phone Central
RUN DEBIAN_FRONTEND=noninteractive apt-get install asterisk -y

# Install HylaFax
RUN DEBIAN_FRONTEND=noninteractive apt-get install hylafax-server -y 

RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get update

# Install Node.js
RUN DEBIAN_FRONTEND=noninteractive apt-get install nodejs -y 

# Make Folders
RUN mkdir /home/root && mkdir /home/root/website && mkdir /home/root/website/express && mkdir /home/root/website/express/styles && mkdir /home/root/website/uploads

# Copy configuration files
COPY initial-configuration-files/etc-asterisk/* /etc/asterisk/
COPY initial-configuration-files/iaxmodem/* /etc/iaxmodem/
COPY initial-configuration-files/etc-vpnc/* /etc/vpnc/
COPY initial-configuration-files/etc-hylafax/ /etc/hylafax/

# Copy Website
COPY first-execution.sh /home/root/
COPY website/ /home/root/website/
COPY website/express* /home/root/website/express/
COPY website/express/styles* /home/root/website/express/styles/

# Run the Node Server
RUN chmod 777 /home/root/first-execution.sh
WORKDIR /home/root/website
# ENTRYPOINT ["/home/root/first-execution.sh"]


