#!/bin/bash

TARGET_IPs_LIST='./ir.domains.list'
TARGET_URL="https://github.com/chiroots/iran-hosted-domains/releases/latest/download/domains.txt"
TARGET_FNAME="./vpn-policy-routing_tmp_ir_raw_domains"

REQUIRED_PKG="parallel"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG | grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
	echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
	sudo apt-get --yes install $REQUIRED_PKG
fi

if [ ! -s "$TARGET_FNAME" ]; then
	curl -L -o "$TARGET_FNAME" "$TARGET_URL" 
fi
if [ -s "$TARGET_FNAME" ]; then
	lkup() {
		if ! nslookup -type=A $1 8.8.8.8| grep -v "can't find"; then
			echo $1
		fi
	}
	export -f lkup

	parallel -j 64 lkup <"$TARGET_FNAME" | awk '/^Address: / { print $2 }' >$TARGET_IPs_LIST
fi
rm -f "$TARGET_FNAME"
