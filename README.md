# Fax over Internet Protocol (FOIP) for the Fritz!Box

Welcome !

This Container will allow you to send FAXes free of charge through a Fritz!Box Router
from AVM Systems Berlin

Installation Instructions:

(For Kubernetes Minikube)

Create a folder on your computer and in this folder run the following, through the command line:

----

minikube start

git clone https://github.com/pablitomilenio/t38-and-iax-containerbase.git

cd t38-and-iax-containerbase

kubectl apply -f Start-Fax-Service

----
