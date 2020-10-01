#!/bin/bash
echo "EXECUTE ESTE PROGRAMA EM ROOT!!"
echo "EXECUTE ESTE PROGRAMA EM ROOT!!"
echo "EXECUTE ESTE PROGRAMA EM ROOT!!"
echo "EXECUTE ESTE PROGRAMA EM ROOT!!"
echo "EXECUTE ESTE PROGRAMA EM ROOT!!"
sleep 4
echo "INICIANDO CONFIGURAÇÃO..........."
sleep 2
#################################################################################################
# Limpa as configurações existentes
iptables -F
iptables -t nat -F
iptables -t mangle -F
##################################################################################################
# A PARTIR DAQUI COMEÇA A CONFIGURAÇÃO DO FIREWALL
##################################################################################################
# A linha abaixo ativa o módulo do netfilter que evita ataques DoS 
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
#Liberar portas dos serviços necessários
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
# A linha abaixo faz o bloqueio de conexões nas demais portas
iptables -A INPUT -p tcp --syn -j DROP
##################################################################################################
#Bloquear algumas tentativas de scanner
iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL FIN,SYN -j DROP
####################################################################################################
#Proteção contra Syn-floods
iptables -A FORWARD -p tcp --syn -m limit --limit 1/s -j ACCEPT

#Port scanners ocultos
iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

#Ping da morte
iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT

Proteção Contra IP Spoofing
iptables -A INPUT -s 10.0.0.0/8 -i Interface da NET -j DROP
iptables -A INPUT -s 172.16.0.0/16 -i Interface da NET -j DROP
iptables -A INPUT -s 192.168.0.0/24 -i Interface da NET -j DROP
#Obs.: Interface da NET pode ser ppp0, ethX e etc.
####################################################################################################
#Bloquear pacotes inválidos
iptables -t filter -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -t filter -A FORWARD -m conntrack --ctstate INVALID -j DROP
####################################################################################################
echo "configuração implementada a baixo"
sleep 3
iptables -L
