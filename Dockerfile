# Set the base image to Ubuntu 18.04, which is compatible with the legacy fax packages that come precompiled
FROM ubuntu:bionic

# Port exposures
EXPOSE 500/udp
EXPOSE 500/tcp
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

# Install StrongSwan
# ENV VERSION="5.9.8"

# Update to the latest packages list (mandatory, if not it will not know iaxmodem)
RUN apt-get update && apt-get install git wget inetutils-ping nano -y

# Install IAX Modem
RUN apt-get install iaxmodem -y

# Expose IKE and NAT-T ports
EXPOSE 500 4500

# Install FOP
RUN apt-get install fop -y

# Install VPNC
RUN apt-get install -y vpnc

# Install Network-Manager
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y network-manager-vpnc

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
RUN mkdir /home/root && mkdir /home/root/website && mkdir /home/root/website/express && mkdir /home/root/website/express/styles && mkdir /home/root/website/uploads && mkdir /home/root/website/prot/

# Copy configuration files
COPY initial-configuration-files/etc-asterisk/* /etc/asterisk/
COPY initial-configuration-files/iaxmodem/* /etc/iaxmodem/
COPY initial-configuration-files/etc-vpnc/* /etc/vpnc/
COPY initial-configuration-files/swan/ /etc/

# Copy configuration files Network-Manager
COPY initial-configuration-files/etc-NM/* /etc/NetworkManager/system-connections/
RUN rm /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf && touch /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf
RUN touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf  

#COPY initial-configuration-files/etc-hylafax/ /etc/hylafax/
RUN touch /etc/hylafax/config.ttyIAX0
RUN touch /var/spool/hylafax/config.ttyIAX0

# Copy Website
COPY first-execution.sh /home/root/
COPY Test-Fax-PDF.pdf /home/root/
COPY website/ /home/root/website/
COPY website/express* /home/root/website/express/
COPY website/express/styles* /home/root/website/express/styles/

# Run NPM Install
RUN npm --prefix /home/root/website install /home/root/website

# Run the Node Server
RUN chmod 777 /home/root/first-execution.sh
WORKDIR /home/root/
ENTRYPOINT ["/home/root/first-execution.sh"]


