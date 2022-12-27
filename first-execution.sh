#!/bin/bash

exec service iaxmodem start &
exec iaxmodem ttyIAX0 &
exec service asterisk start &
exec service hylafax start &
exec service dbus start &
exec service network-manager start &
exec asterisk &
exec asterisk &
exec node /home/root/website/server.js
