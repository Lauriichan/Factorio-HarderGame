VAR=
while read -r line; do {
    if [[ "$line" == ---* ]]; then
        if [ $VAR == "" ]; then 
            continue;
        fi
        echo $VAR
        return
    fi
    VAR=$VAR + '\n' + $line
}; done < changelog.txt
echo $VAR
return