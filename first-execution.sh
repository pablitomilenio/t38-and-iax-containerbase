#!/bin/bash

exec vpnc fritzbox &
exec service iaxmodem start &
exec iaxmodem ttyIAX0 &
exec service asterisk start &
exec service hylafax start &
exec asterisk &
exec asterisk &
exec service dbus start &
exec service network-manager start &
exec node /home/root/website/server.js
