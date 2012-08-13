export BUNDLER_EDITOR='vi'

# Customize to your needs...
export PATH=/usr/local/bin:$PATH

export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH

if [[ `uname` == 'Darwin' ]]; then
  export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
  export PATH=/Applications/MAMP/Library/bin:$PATH
  export PATH=/Applications/MAMP/bin/php/php5.2.17/bin:$PATH
  export PATH=/Applications/MAMP/bin/php/php5.3.6/bin:$PATH

  # Postgres.app
  export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
fi
