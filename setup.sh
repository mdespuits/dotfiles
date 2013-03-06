export DOTIFY_BIN=$DOTIFY_HOME/bin
export DOTIFY_SCRIPTS=$DOTIFY_HOME/scripts

source "$DOTIFY_SCRIPTS/platform.bash"

chmod 500 $DOTIFY_BIN;

for file in $DOTIFY_BIN/*; do
  if [ -f $file ] ; then
    chmod 500 $file
  fi
done

export PATH="$DOTIFY_BIN:$PATH"

for file in $DOTIFY_SCRIPTS/*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
