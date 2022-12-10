# Set the base image to Ubuntu 18.4
FROM ubuntu:bionic

# Info: please name this image: "FOIP-containerbase" for further use in docker" for further use in compose

# Update the repository sources list and install CAPI (As a small addition to the container functionalities)
# RUN apt-get install -y capiutils libcapi20-3 git wget

# Update to the latest packages list
RUN apt-get update

# Install IAX Modem
RUN sudo apt-get install iaxmodem -y

# Install T.38 Modem
RUN sudo apt-get install t38modem -y

# Install The Asterix Phone Central
RUN sudo apt-get install asterisk -y

# Install HylaFax
RUN sudo apt-get install hylafax-server -y

# Mark the working directory as safe
RUN git config --global --add safe.directory /com.docker.devenvironments.code


