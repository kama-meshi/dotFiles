DIR=$(cd $(dirname $0); pwd)
FILE=$(basename $0)

for f in $DIR/*.zsh; do
  if [[ "$FILE" = "$(basename $f)" ]]; then
    continue
  fi
  source $f
done
