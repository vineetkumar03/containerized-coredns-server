# containerized-coredns-server
containerized-coredns-server
After run the script go to client machine and enter IP of DNS server in netplan file in ubuntu18.04     
```
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        ens3:
            dhcp4: true
            nameservers:
                    addresses:
                    - 10.10.x.x
        ens4:
            dhcp4: true
            optional: true
    version: 2
```
    
    
   ###### After that run below commands
```
netplan generate     
netplan apply 
```
Run Following command To check connectivity from each node to DNS server
```
netcat -uzv <DNS-SERVER-IP> <PORT>  
```
