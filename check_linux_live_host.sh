#!/bin/bash

TARGET="$1"

checkArgs(){
    if [[ $# -eq 0 ]]; then
        echo -e "ERROR: Invalid argument!"
        echo -e "[+] USAGE:$0 x.x.x"
        exit 1
    fi
}

checkLive(){
    tmp=(${TARGET//\./ })
    for ip in ${tmp[0]}.${tmp[1]}.${tmp[2]}.{0..255};
        do
            ping -c 1 $ip >> /dev/null
            if [ $? = 0 ]; then
                echo "$ip is up"
            else
                echo "$ip is down"
            fi
        done
    exit 0
}

checkArgs $TARGET
checkLive
exit 1
