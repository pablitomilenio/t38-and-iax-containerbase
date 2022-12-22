#!/bin/bash

exec service iaxmodem start &
exec service asterisk start &
exec service hylafax start &
exec asterisk &
exec asterisk &
exec node /home/root/website/server.js &