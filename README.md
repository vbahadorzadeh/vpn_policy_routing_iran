# vpn_policy_routing_iran
list of iran hosted ips to be used by vpn-policy-routing on openwrt 

to create the list change TARGET_URL= in vpr_get_ip_list.sh to a list of domains as you like & run vpr_get_ip_list.sh (might take a while)

otherwise just copy ir.domains.list to /var & copy vpn-policy-routing-iran.user to /etc 
then add a custom user file includes in vpn-policy-routing luci interface path=/etc/vpn-policy-routing-iran.user
save & enjoy 


note that i assumed you routed ir traffic thorough wan interface 
but you may change the interface from TARGET_IPSET='wan' to any other interface you want

Thanks to https://github.com/chiroots/iran-hosted-domains/ for gathering the list of domains
