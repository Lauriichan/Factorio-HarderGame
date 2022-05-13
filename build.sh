mkdir tmp
rsync -av --progress * /tmp --exclude tmp
rm -f tmp/build.sh
rm -f -r tmp/.github/
rm -f tmp/.gitignore
zip $1-$2.zip -r tmp/