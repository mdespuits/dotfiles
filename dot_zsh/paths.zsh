function add_path_before() {
  if [ -d "$1" ]; then
    PATH="$1:$PATH"
  fi
}

# if [ -d "$(brew --prefix)/bin" ]; then
#   eval "$($(brew --prefix)/bin/brew shellenv)"
# fi

# =================================
# MySQL
# =================================
add_path_before "/usr/local/opt/mysql@5.7/bin"

# =================================
# Postgres.app
# =================================
add_path_before "/Applications/Postgres.app/Contents/Versions/latest/bin"

# =================================
# OpenSSL update fix
# =================================
if [ -d "/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt" ]; then
  export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
fi

# =========================
# Composer
# =========================
add_path_before "$HOME/.composer/vendor/bin"

# =================================
# Deno
# =================================
add_path_before "$HOME/.deno/bin"
export DENO_INSTALL="$HOME/.deno"

# =================================
# Go
# =================================
add_path_before "$HOME/go/bin"

add_path_before "$HOME/.bin"
add_path_before "$HOME/.localbin"

add_path_before "/usr/local/opt/icu4c/bin:/usr/local/opt/icu4c/sbin"
