#!/bin/bash
# Script que presenta un menu para realizar backups de router y switches Cisco

# Primero limpiamos la terminal para que quede bonito
clear

# Definiendo las variables
log=./log_errores
lock=./backup.lock

# Mostramos las diferentes opciones disponibles
while :
do

echo " ****************************** "
echo "      Escoja una opcion "
echo " ****************************** "
echo " "
echo " "
echo "1. Realizar backup routers"
echo " "
echo "2. Realizar backup switches"
echo " "
echo "3. Realizar backup de routers y switches"
echo " "
echo "4. Insertar ip a la lista de routers"
echo " "
echo "5. Insertar ip a la lista de switches"
echo " "
echo "6. Ver log"
echo " "
echo "7. Limpiar log"
echo " "
echo "9. Salir"
echo " "
#  Segun la opcion que marquemos no llevara a la seccion correcta.
echo -n "Seleccione una opcion [1 - 9] "
read opcion
case $opcion in

1) if [ ! -e $lock ]; then
   trap "rm -f $lock; exit" INT TERM EXIT
   touch $lock
   echo "Se realizara backup routers"
   echo "$DATE" >> $log
   ./while_loop_routers.sh ips_routers
   trap - INT TERM EXIT
else
   echo "Backup ejecutandose"
fi;;

2) if [ ! -e $lock ]; then
   trap "rm -f $lock; exit" INT TERM EXIT
   touch $lock
   echo "Se realizara backup switches"
   echo "$DATE" >> $log
   ./while_loop_glan.sh ips_glan
   trap - INT TERM EXIT
else
   echo "Backup ejecutandose"
fi;;

3) if [ ! -e $lock ]; then
   trap "rm -f $lock; exit" INT TERM EXIT
   touch $lock 
   echo "Se realizara backup router y switches"
   echo "$DATE" >> $log
   ./while_loop_routers.sh ips_routers
   ./while_loop_glan.sh ips_glan
   trap - INT TERM EXIT
else
   echo "Backup ejecutandose"
fi;;


4) read -p "Introduce la ip: " ip_router;
echo $ip_router >> ips_routers;;

5) read -p "Introduce la ip: " ip_glan;
echo $ip_glan >> ips_glan;;

6) cat log_errores;;

7) cat /dev/null > log_errores;;

9) echo "Salir";
exit 1;;
*) echo "$opcion es una opcion invalida. Es tan dificil?";
echo "Presiona enter para continuar...";
read foo;;
esac
done
