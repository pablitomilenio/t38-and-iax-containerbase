#!/bin/bash

exec service ike start &
exec ikec -r winfritz.vpn -u pablo.escaida -p Fr@Q319j@zML -a &
