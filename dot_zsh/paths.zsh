# =================================
# PATH info
# =================================

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
if [ -d "/usr/local/heroku/bin" ]; then
  export PATH=/usr/local/heroku/bin:$PATH
fi

# =================================
# MySQL
# =================================
if [ -d "/usr/local/opt/mysql@5.7/bin" ]; then
  export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
fi


# =================================
# Vagrant
# =================================
if [ -d "/Applications/Vagrant/bin" ]; then
  export PATH="/Applications/Vagrant/bin:$PATH"
fi

# =================================
# Postgres.app
# =================================
if [ -d "/Applications/Postgres.app/Contents/Versions/latest/bin" ]; then
  export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
fi

# =================================
# OpenSSL update fix
# =================================
if [ -d "/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt" ]; then
  export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
fi

# =========================
# Composer
# =========================
if [ -d "$HOME/.composer/vendor/bin" ]; then
  export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# =================================
# Deno
# =================================
if [ -d "$HOME/.deno" ]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

# =================================
# Go
# =================================
if [ -d "$HOME/go/bin" ]; then
  export PATH=$HOME/go/bin:$PATH
fi

if [ -d "$HOME/.bin" ]; then
  chmod -R 755 $HOME/.bin
  export PATH=$HOME/.bin:$PATH
fi

if [ -d "$HOME/.localbin" ]; then
  chmod -R 755 $HOME/.localbin
  export PATH=$HOME/.localbin:$PATH
fi

export PATH="/usr/local/opt/icu4c/bin:/usr/local/opt/icu4c/sbin:$PATH"
