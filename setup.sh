export DOTIFY_BIN=$DOTIFY_HOME/bin
export DOTIFY_SCRIPTS=$DOTIFY_HOME/scripts

source "$DOTIFY_SCRIPTS/platform.bash"

chmod 700 $DOTIFY_BIN;

for file in $DOTIFY_BIN/*; do
  if [ -f $file ] ; then
    chmod 755 $file
  fi
done

export PATH="$DOTIFY_BIN:$PATH"

for file in $DOTIFY_SCRIPTS/*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
