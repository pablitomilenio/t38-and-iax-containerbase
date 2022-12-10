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

The advantage of the T38 protocol, according to AVM, the FritzBox manufacturer, is that the transmission takes place over a Network-Protocol and not over Signal-Tones which can be corrupted by the TCP Protocol

![image](https://user-images.githubusercontent.com/34131550/206872174-895cac75-5988-462e-90c2-0a508ce1aaa0.png)

Fax Over IP (FOIP)
