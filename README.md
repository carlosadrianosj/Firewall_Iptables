Este repositório é dedicado a armazenar configurações para implementação de regras iptables. Se assim como eu você possui um servidor firewall em sua residência, vale a pena testar!

No arquivo .txt você poderá encontrar configurações que eu achei extremamente úteis para implementação.

O arquivo firewall.sh é nada mais do que uma configuração que eu já deixei pronta para implementação, teste ela em seu firewall, e verifique se as mesmas estão atendendo os requisitos que precisa!

Caso queira adicionar o firewall.sh a inicialização do servidor firewall, siga os passos abaixo:

Adicione o firewall.sh em /usr/local/bin

Adicione o firewall.service em /etc/systemd/system

Logo após fazer isso, só é necessario apenas executar os seguintes comandos:

#para atualizar o systemd systemctl daemon-reload

#para ativar o serviço e inicializar o firewall junto com o servidor systemctl enable firewall

#para deixar o serviço ativo systemctl start firewall

Para ter certeza que tudo foi implementado, reinicialize seu servidor e verifique as regras com iptables -L

Caso queira retirar as regras, utilize iptables -F
