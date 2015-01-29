#!/bin/bash

log=./log_errores

while read -a ips
do

IP=${ips[0]}

ping -c 2 $IP > /dev/null
resp=$?

if [ $resp != 0 ]; then 

echo "Equipo $IP no responde" >> $log
else
./backup_routers.exp $IP

fi

done < $1
exit 0
