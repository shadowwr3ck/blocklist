# blocklist

PREREQUISITES 

`sudo apt install iptables ipset`

Firewall 
rules.v4 with predefined iptable rules


# DESCRIPTION #

You ever get annoyed by having to block ips that are malicious or get tired of seeing the same countries and their servers attack your server.   It's time to fix that.


This script will auto download predefidned ipblock lists from ipdeny.com.
It will also insert the blocks lists into their specified directories.

Once your variables are defined to your liking. Run the script.

It will
Create the ipset block name.
Download the blocklists.
Insert the blocklists into a directory you specified.
Re-Enable your firewall.


There are variables within the script that you can configure for your liking.
