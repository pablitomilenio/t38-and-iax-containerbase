#!/bin/bash

exec service iaxmodem start &
exec iaxmodem ttyIAX0 &
exec service asterisk start &
exec service hylafax start &
# exec service ike start &
exec asterisk &
exec asterisk &
# exec vpnc fritzbox &
# exec service dbus start &
# exec service network-manager start &
# exec service ipsec start &
# exec ipsec up fritzbox &
# exec ikec -r winfritz.vpn -u pablo.escaida -p Fr@Q319j@zML -a &
exec node /home/root/website/server.js
