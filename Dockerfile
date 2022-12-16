# Set the base image to Ubuntu 18.04, which is compatible with the legacy fax packages that come precompiled
FROM ubuntu:bionic

# Port exposures
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
RUN apt-get update && apt-get install git wget inetutils-ping nano vpnc -y

# Install IAX Modem
RUN apt-get install iaxmodem -y

# Install T.38 Modem
RUN apt-get install t38modem -y

# Install The Asterix Phone Central
RUN DEBIAN_FRONTEND=noninteractive apt-get install asterisk -y

# Install HylaFax
RUN DEBIAN_FRONTEND=noninteractive apt-get install hylafax-server -y 

# Install Node.js
RUN DEBIAN_FRONTEND=noninteractive apt-get install node.js npm -y 

# Make Folders
RUN mkdir /home/root && mkdir /home/root/website && mkdir /home/root/website/express && mkdir /home/root/website/express/styles

# Copy configuration files
COPY initial-configuration-files/etc-asterisk/* /etc/asterisk
COPY initial-configuration-files/iaxmodem/* /etc/iaxmodem
COPY initial-configuration-files/etc-vpnc/* /etc/vpnc


# Copy Website
COPY website/* /home/root/website
COPY website/express* /home/root/website/express
COPY website/express/styles* /home/root/website/express/styles

# Install Express
RUN npm --prefix /home/root/website/ install /home/root/website

# Run the Node Server
WORKDIR /home/root/website
ENTRYPOINT [ "npm", "start" ]


