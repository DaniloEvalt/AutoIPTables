#!/bin/bash
#
echo "Permitindo IP 201.62.64.3" 
iptables -A INPUT -s 201.62.64.3 -p tcp -j ACCEPT
iptables -A INPUT -s 201.62.64.3 -p udp -j ACCEPT

echo "Dropando outros ip's via SSH"
iptables -A INPUT -p tcp --dport 6022 -j DROP

echo Alterando o arquivo hosts.allow
echo sshd: 201.62.64.3 >> /etc/hosts.allow
echo Alterando o arquivo hosts.deny
echo sshd: ALL >> /etc/hosts.deny

echo "Alterando a porta SSH"
echo Port 6022 >> /etc/ssh/sshd_config

echo "Reiniciando SSHD"
systemctl restart sshd

echo "Rotacionando LOGs"
logrotate --force --verbose /etc/logrotate.conf


echo "Bloqueando lista de IPs perigosos"

iptables -F

wget -O - https://raw.githubusercontent.com/DaniloEvalt/IPs-para-bloqueio/master/ip.sh | bash

/sbin/service iptables save 
