# First Execution Script

service iaxmodem start &
service asterisk start &
iaxmodem ttyIAX0 &
asterisk &
cd /home/root/website
npm start &