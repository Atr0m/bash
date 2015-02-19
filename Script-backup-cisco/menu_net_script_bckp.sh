#!/bin/bash

log=./log_errores
lock=./backup.lock

if [ ! -e $log ]
    then
        touch $log
fi

while :
do
clear
echo " ****************************** "
echo "      Escoja una opcion "
echo " ****************************** "
echo " "
echo " "
echo "1. Realizar backup routers"
echo " "
echo "2. Realizar backup switch"
echo " "
echo "3. Realizar backup de routers y switch"
echo " "
echo "4. Insertar ip a la lista de routers"
echo " "
echo "5. Insertar ip a la lista de switch"
echo " "
echo "6. Realizar backup de 1 equipo"
echo " "
echo "7. Ver log"
echo " "
echo "8. Limpiar log"
echo " "
echo "9. Salir"
echo " "
echo -n "Seleccione una opcion [1 - 9] "
read opcion
case $opcion in

1)  if [ ! -e $lock ]; then
        trap "rm -f $lock; exit" INT TERM EXIT
            touch $lock
            echo "Se realizara backup routers"
            echo "$DATE" >> $log
            ./while_loop_routers.sh ips_routers
            rm $lock
        trap - INT TERM EXIT
    else
        echo "Backup ejecutandose"
    fi;;

2)  if [ ! -e $lock ]; then
        trap "rm -f $lock; exit" INT TERM EXIT
            touch $lock
            echo "Se realizara backup switch"
            echo "$DATE" >> $log
            ./while_loop_switch.sh ips_switch
            rm $lock
        trap - INT TERM EXIT
    else
        echo "Backup ejecutandose"
    fi;;

3)  if [ ! -e $lock ]; then
        trap "rm -f $lock; exit" INT TERM EXIT
            touch $lock 
            echo "Se realizara backup router y switch"
            echo "$DATE" >> $log
            ./while_loop_routers.sh ips_routers
            ./while_loop_switch.sh ips_switch
            rm $lock
        trap - INT TERM EXIT
    else
        echo "Backup ejecutandose"
fi;;


4)  read -p "Introduce la ip: " ip_router;
        echo $ip_router >> ips_routers;;

5)  read -p "Introduce la ip: " ip_switch;
        echo $ip_glan >> ips_switch;;

6)  clear
    echo "Elige el tipo de equipo"
    echo "1. Router"
    echo "2. Switch"

    read equipo
    case $equipo in
        1)  read -p "Introduce la ip del router: " ip_equipo;
                if [ ! -e $lock ]; then
                    trap "rm -f $lock; exit" INT TERM EXIT
                        touch $lock
                        echo "Se realizara backup del equipo $ip_equipo"
                        ./backup_routers.exp $ip_equipo
                        rm $lock
                    trap - INT TERM EXIT
                else
                    echo "Backup del equipo $ip_equipo ejecutandose"
                fi;;

        2)  read -p "Introduce la ip del switch: " ip_equipo;
                if [ ! -e $lock ]; then
                    trap "rm -f $lock; exit" INT TERM EXIT
                        touch $lock
                        echo "Se realizara backup del equipo $ip_equipo"
                        ./backup_switch.exp $ip_equipo
                        rm $lock
                    trap - INT TERM EXIT
            else
                echo "Backup del equipo $ip_equipo ejecutandose"
                fi;;
    esac;;
7)  cat log_errores
        echo "Presiona enter para continuar...";
    read foo;;

8)  cat /dev/null > log_errores;;

9)  echo "Salir";
exit 1;;

*)  echo "$opcion es una opcion invalida. Es tan dificil?";
    echo "Presiona enter para continuar...";
        read foo;;
esac
done
