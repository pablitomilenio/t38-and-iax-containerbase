# t38-and-iax-containerbase
Container for sending Faxes with a FritzBox using IAXmodem and T38modem with Hylafax and Asterisk Phone Server

This Container installs the Ubuntu 18.04 base environment

On top there is meant to be

IAX-Modem
T38-Modem

HylaFax
Asterisk Phone Server


Theory:

Old FAX Machines are using phone-lines with continuous electric current
The current Internet and the TCP Protocol divide everyting into packets (non continuous)

The Software Modems that I am providing in this container work over the SIP Protocol using the capabilities of a FritzBox
they simulate an old phone line communication over VoIP

The picture shows how from a foreign country behind VPN the connection still establishes, but tries to make adjustments to correct line jitter because of the VPN encryption


![call accepted](https://user-images.githubusercontent.com/34131550/206871856-7fb2ec09-77cf-4d60-b1b5-be1ba42cb460.png)

