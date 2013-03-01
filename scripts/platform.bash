platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='mac'
fi

if [[ $platform == 'linux' ]]; then
  export CC='/usr/bin/gcc'
  export PATH=$PATH:$HOME/bin:/sbin
else
  export CC='gcc-4.2'
fi
