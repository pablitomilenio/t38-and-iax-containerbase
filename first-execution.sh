#!/bin/bash

exec service iaxmodem start &
exec service asterisk start &
exec service hylafax start &
exec iaxmodem ttyIAX0 &
exec asterisk &
exec node /home/root/website/server.js