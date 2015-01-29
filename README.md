#Bash

Some Scrits in bash

## Contenido

[**Telnet_cisco.sh**](https://github.com/Atr0m/bash/blob/master/telnet_cisco.sh) Script para conectarse a un router Cisco por telnet y mostrar el estado de las interfaces.

#### Script para backup masivo de routers y switches cisco.

Primero hay un menú para lanzar los scripts de forma más comoda y alguna otra cosa.  
[**menu_net_script_bckp.sh**](https://github.com/Atr0m/bash/blob/master/Script-backup-cisco/menu_net_script_bckp.sh)

Luego están los script donde se realiza un bucle while con las ips que lee de un archivo plano con las ips de acceso a los router y switches.  
[**while_loop_routers.sh**](https://github.com/Atr0m/bash/blob/master/Script-backup-cisco/while_loop_routers.sh)  
[**while_loop_switch.sh**](https://github.com/Atr0m/bash/blob/master/Script-backup-cisco/while_loop_switch.sh)

Después están los scripts en [expect](http://en.wikipedia.org/wiki/Expect) para conectarse a los equipos y extraer por tftp la configuración.  
[**backup_routers.exp**](https://github.com/Atr0m/bash/blob/master/Script-backup-cisco/backup_routers.exp)  
[**backup_switch.exp**](https://github.com/Atr0m/bash/blob/master/Script-backup-cisco/backup_switch.exp)

***

## Content

[**Telnet_cisco.sh**](https://github.com/Atr0m/bash/blob/master/telnet_cisco.sh) Script to connect a Cisco router using telnet and show the interfaces status
