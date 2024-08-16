#!/bin/bash
tgtd &
sleep 2
tgtadm --mode target --op new --tid 1 --targetname $targetname

i=1
for var in $(compgen -e); do
    if [[ $var == *lundev* ]]; then
        tgtadm --mode logicalunit --op new --tid 1 --lun $i --backing-store ${!var}
        ((i++))
    fi
done

tgtadm --mode target --op bind --tid 1 --initiator-address $ip_address

sleep infinity

