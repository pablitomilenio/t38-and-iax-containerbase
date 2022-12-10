# t38-and-iax-containerbase
Container for sending Faxes with a FritzBox using IAXmodem and T38modem with Hylafax and Asterisk Phone Server

This Container installs the Ubuntu 18.04 base environment



On top there is meant to be

IAX-Modem    -    Software Modem that emulates a legacy hardware Modem

T38-Modem    -    Software Modem that also emulates a legacy modem but transfers via the T38 Protocol instead over tones

HylaFax      -    Arguably the most professionally developed open-source Fax-Sending-Software

Asterisk     -    A Software Switchbox (Telefonzentrale) that supports SIP and can connect to the FritzBox


The SIP Protocol used by the Asterix Server and the T.38 Protocol are some of the most important protocols that the FritzBox supports


![image](https://user-images.githubusercontent.com/34131550/206872917-609c6034-055a-481c-b080-6c6019331766.png)



Theory:

Old FAX Machines are using phone-lines with continuous electric current
The current Internet and the TCP Protocol divide everyting into packets (non continuous)

The Software Modems that I am providing in this container work over the SIP Protocol using the capabilities of a FritzBox
they simulate an old phone line communication over VoIP

The advantage of the T38 protocol, according to AVM, the FritzBox manufacturer, is that the transmission takes place over a Network-Protocol and not over Signal-Tones which can be corrupted by the TCP Protocol

![image](https://user-images.githubusercontent.com/34131550/206872174-895cac75-5988-462e-90c2-0a508ce1aaa0.png)

Fax Over IP (FOIP)
