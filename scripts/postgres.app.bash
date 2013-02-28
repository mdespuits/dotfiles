source $DOTIFY_HOME/scripts/aliases.bash

if [[ $platform == 'mac' ]]; then
  PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
fi
