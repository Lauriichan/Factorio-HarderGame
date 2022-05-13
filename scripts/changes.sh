VAR=
while read -r line; do {
    if [[ "$line" == ---* ]]; then
        if [[ $VAR == "" ]]; then 
            continue;
        fi
        break
    fi
    VAR+="$line<br>"
}; done < changelog.txt
echo $VAR