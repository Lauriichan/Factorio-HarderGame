mkdir tmp
rsync -av --progress * /tmp --exclude tmp
rm -r tmp/scripts
rm -r tmp/.github
rm -f tmp/.gitignore
mv tmp/ $1/
zip $1_$2.zip -r $1/
echo "$1_$2.zip"
rm -r $1
