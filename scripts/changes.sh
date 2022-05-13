VAR=
while read -r line; do {
    if [[ "$line" == ---* ]]; then
        if [[ $VAR == "" ]]; then 
            continue;
        fi
        break
    fi
    VAR=$'$VAR \n $line'
}; done < changelog.txt
echo $VAR