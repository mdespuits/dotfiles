export DOTIFY_SCRIPTS=$DOTIFY_HOME/scripts

for file in $DOTIFY_SCRIPTS/*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
