#!/bin/bash

chmod +777 ./main.sh
exec 9<./input_proxies.txt
echo "Enter timeout(recomended not less then 2 seconds):"
read TIMEOUT
let OK_COUNTER=0
let TOTAL_COUNTER=0

while read <&9 INPUT_PROXY
    do 
        RESPONSE=$(curl -LI https://www.google.com -o /dev/null -w '%{http_code}\n' -s --proxy $INPUT_PROXY --connect-timeout $TIMEOUT)
        if [[ $RESPONSE -eq "200" ]]; then
            echo $INPUT_PROXY
            echo "STATUS: OK"
            echo "----------------------"
            echo $INPUT_PROXY >> output_proxies.txt
            let OK_COUNTER++
        fi
        if [[ $RESPONSE -ne "200" ]]; then
            echo $INPUT_PROXY
            echo "STATUS: BAD"
            echo "----------------------"
        fi
        let TOTAL_COUNTER++
    done

echo "--------RESULT--------"
echo "Total proxies:"
echo $TOTAL_COUNTER
echo "----------------------"
echo "Total OK proxies:"
echo $OK_COUNTER
echo "---Made by DimonBor---"