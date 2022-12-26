# Fax over Internet Protocol (FOIP) for the Fritz!Box

Welcome !

This Container will allow you to send FAXes free of charge through a Fritz!Box Router
from AVM Systems Berlin

Installation Instructions:

Download the container using

sudo docker pull pablitomilenios/fritzbox-foip-fax-over-ip:latest

then run the container using

sudo docker run -P -ti --network=host pablitomilenios/fritzbox-foip-fax-over-ip

when the container is running enter into:

https://localhost:3000

in your browser.

There enter the Status Page and make sure you are in the same local network of the Fritz!Box
Make sure the SIP and IAX clients are working as indicated by the status page. This can take 3-5 minutes to load / establish connection

Once ready send the PDF Fax via the designated html page for that task.

----
