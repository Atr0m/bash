#!/bin/sh

host=192.168.1.123
port=23
user=myuser
pass=mypassword
cmd1="show ip interfece brief"

( echo open ${host} ${port}
sleep 3
echo ${user}
sleep 1
echo ${pass}
sleep 1
echo ${cmd1}
sleep 1
echo exit ) | telnet
