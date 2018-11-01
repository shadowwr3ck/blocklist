#!/bin/bash

# README #

# Scroll through the script and uncomment things you want personalized.
# Example.  If you want to block AMAZON AWS servers from hitting your server totally.  Scroll and uncomment all the amazon stuff #

# Your firewall(iptables) must also contain the ipset link for your ipset block #



filetime=$(stat -c %Y /etc/banblocks/zones) 
two_days_ago=$(date -d "2 days ago" +%s) 
domain='http://ipdeny.com/ipblocks/data/countries' 
#cflare='https://www.cloudflare.com/ips-v4' 
#amazon_get=$(/root/jq-linux64 -r '.prefixes | .[].ip_prefix' < /root/ip-ranges.json > /etc/banblocks/zones/amazon.zone)
#amazon='/amazon.zone'
#Do NOT CHANGE   
zonefile1='/sg.zone' 
zonefile2='/jp.zone' 
zonefile3='/cn.zone' 
zonefile4='/fr.zone' 
zonefile5='/vn.zone' 
zonefile6='/ru.zone'
# END OF DOT NOT CHANGE #
zonedir='/etc/banblocks/zones' 
zones='/etc/banblocks/zones/*.zones' 
firewalldir='/etc/iptables/'
firewall='rules.v4'
#colouring
GREEN='\033[00;32m'
YELLOW='\033[1;33m' 
NC='\033[0m'

#Clear out old and existing iptables rules 
iptables -F

ipset -L cn > /dev/null 2>&1

if [ $? -ne 0 ]; #Says if cn set doesn't exist Run the below
	then
# Create the ipset list
#ipset create fags hash:net
ipset create jp hash:net
ipset create fr hash:net
ipset create cn hash:net
ipset create sg hash:net
ipset create vn hash:net
ipset create ru hash:net
#ipset create amazon hash:net
#ipset create cflare hash:net
else	
echo " ${GREEN} Sets already exist.  Moving on ${NC}"

fi


# if /etc/banblocks/zones doesnt exist. Than create it.  If not. Report so and move on

if [ ! -e "${zones}" ]; then
mkdir -p "$zonedir"
 else
echo -e "${zonesdir} already exists. Exiting"
fi 


	if [ $filetime -lt $two_days_ago ]; then
	
curl "$domain$zonefile1" -o "$zonedir$zonefile1"
echo -e "${YELLOW} Downloaded singapore zone and added to $zonedir ${NC}"
curl "$domain$zonefile2" -o "$zonedir$zonefile2"
echo -e "${YELLOW} Downloaded Japan zone and added to $zonedir ${NC}"
curl "$domain$zonefile3" -o "$zonedir$zonefile3"
echo -e "${YELLOW} Downloaded China zone and added to $zonedir ${NC}"
curl "$domain$zonefile4" -o "$zonedir$zonefile4"
echo -e "${YELLOW} Downloaded France zone and added to $zonedir ${NC}"
curl "$domain$zonefile5" -o "$zonedir$zonefile5"
echo -e "${YELLOW} Downloaded Vietnam Zone and added to $zonedir ${NC}"
curl "$domain$zonefile6" -o "$zonedir$zonefile6" 

#curl "$cflare" -o "$zonedir/cflare.zone"
#echo "${amazon_get}"
#echo -e "${YELLOW} Downloaded Amazon IP BLOCK"

	else
echo "${YELLOW} Zones files are already downloaded & newer than 2 days . Exiting ${NC}"

fi

ipset -L cn > /dev/null 2>&1
if [ $? -ne 0 ]; #Says if cn set doesn't exist Run the below 
	then
# echo -e "for i in $(cat /etc/ipset/zones/cflare.zone ); do ipset add cflare $i; done" #
echo -e "for i in $(cat $zonedir$zonefile1 ); do ipset add cn $i; done"
echo -e "for i in $(cat $zonedir$zonefile2 ); do ipset add sn $i; done"
echo -e "for i in $(cat $zonedir$zonefile3 ); do ipset add jp $i; done"
echo -e "for i in $(cat $zonedir$zonefile4 ); do ipset add vn $i; done"
echo -e "for i in $(cat $zonedir$zonefile5 ); do ipset add fr $i; done"
echo -e "for i in $(cat $zonedir$zonefile6); do ipset add ru $i; done"
#echo -e "for i in $(cat $zonedir$amazon ); do ipset add amazon $i; done"
else
echo  " ${YELLOW} Ipset and zones exist ${NC}.  ${GREEN}Ending and enabling firewall ${NC}"
fi


iptables-restore < $firewalldir$firewall

