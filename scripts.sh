export DOTIFY_SCRIPTS=$DOTIFY_HOME/scripts

source "$DOTIFY_SCRIPTS/platform.bash"

for file in $DOTIFY_SCRIPTS/*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
