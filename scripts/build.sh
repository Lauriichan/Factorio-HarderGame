mkdir tmp
rsync -av --progress * /tmp --exclude tmp
rm -f -r tmp/scripts/
rm -f -r tmp/.github/
rm -f tmp/.gitignore
mv tmp/ $1/
rm -f -r tmp/
zip $1_$2.zip -r $1/
echo "$1_$2.zip"
rm -f -r $1/