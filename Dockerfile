# Set the base image to Ubuntu 18.4
FROM ubuntu:bionic

# Info: please name this image: "fax-containerbase" for further use in docker" for further use in compose

# Update the repository sources list and install CAPI
RUN apt-get update && apt-get install -y capiutils libcapi20-3 git wget

# Mark the working directory as safe
RUN git config --global --add safe.directory /com.docker.devenvironments.code

# Uncomment the following 3 lines for the Roger Router GUI
RUN apt-get install -y flatpak 
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
RUN flatpak install -y https://dl.flathub.org/repo/appstream/org.tabos.roger.flatpakref

# Install Roger Router CLI
#RUN wget http://launchpadlibrarian.net/461419922/roger-router-cli_1.8.14-5_amd64.deb
#RUN dpkg -i roger-router-cli_1.8.14-5_amd64.de

# Install Roger Router CLI Dependencies
#RUN apt-get -f install
