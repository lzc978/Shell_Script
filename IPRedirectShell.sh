#/bin/bash
a=1
while :
do
    a=$(($a+1))
    if test $a -gt 255
    then break
    else
        echo $(ping -c 1 192.168.0.$a | grep "ttl" | awk '{print $4}'| sed 's/://g')
        ip=$(ping -c 1 192.168.0.$a | grep "ttl" | awk '{print $4}'| sed 's/://g')
        echo $ip >> ip.txt
    fi
done