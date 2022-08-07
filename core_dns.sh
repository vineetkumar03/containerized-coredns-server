#!/bin/bash
##*********CREATE DIRECTORY***********
mkdir -p /home/coredns/
echo "Directory Successfully Created"
cd /home/coredns/
##************************************
echo
"domain.name.        IN  SOA dns.cloud.gov.in. pvtdns.domain.name. 2015082541 7200 3600 1209600 3600   
service-name1      IN A    10.10.x.x  
service2             IN A    10.10.x.x" >/home/coredns/domain.name.db
echo 
".:53 {   
    forward . 164.100.3.1  # GATEWAy IP
    log  
    errors  
}
domain.name:53 {
    file /root/domain.name.db
    log
    errors
} " > /home/coredns/Corefile
echo "Both files domain.name.db and Corefile is  created successfully"
############ STOP Resolved Service If Running####################### 
RESOLVE_SERVICE="systemd-resolve"
if pgrep -x "$RESOLVE_SERVICE" >/dev/null
then
echo "$RESOLVE_SERVICE is running So stopping the resolve service"
systemctl stop systemd-resolved
systemctl disable systemd-resolved
else 
echo "$RESOLVE_SERVICE is not running so Start Docker."
fi
############*************************#########################

docker run -d --name coredns -p 53:53/udp --restart=always --volume=/home/coredns/:/root/ coredns:1.8.4 -conf /root/Corefile
docker ps | grep coredns
############***************************************
