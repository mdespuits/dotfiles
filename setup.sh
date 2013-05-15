export DOTIFY_BIN=$DOTIFY_HOME/bin
export DOTIFY_SCRIPTS=$DOTIFY_HOME/scripts

source "$DOTIFY_SCRIPTS/platform.bash"

chmod -R 755 $DOTIFY_BIN;

for file in $DOTIFY_SCRIPTS/*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
