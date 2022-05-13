mkdir tmp
rsync -av --progress * /tmp --exclude tmp
rm -r tmp/scripts
rm -r tmp/.github
rm -f tmp/.gitignore
move tmp/ $1/
rm -r tmp
zip $1_$2.zip -r $1/
echo "$1_$2.zip"
rm -r $1
