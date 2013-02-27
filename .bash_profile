#!/bin/bash

export JAVA_HOME=/usr/java/default
export CATALINA_HOME=/var/lib/tomcat6/webapps
export CATALINA_OPTS="-server -Xms512m -Xmx1536m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=512m -XX:MaxPermSize=512m -XX:+DisableExplicitGC -Duser.timezone=GMT -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000"

export SHELL_NAME=bash

# Adding /url/local/bin for Homebrew
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export DOTIFY_HOME=$HOME/.dotify
export DOTIFY_SCRIPTS=$DOTIFY_HOME/scripts

for f in $DOTIFY_SCRIPTS*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done

##########
# Colors #
##########
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

# Prompt Setup
function minutes_since_last_commit {
  now=`date +%s`
  last_commit=`git log --pretty=format:'%at' -1`
  seconds_since_last_commit=$((now-last_commit))
  minutes_since_last_commit=$((seconds_since_last_commit/60))
  echo $minutes_since_last_commit
}

# Current Git branch
function git_prompt {
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
    if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
      local COLOR=${txtred}
    elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
      local COLOR=${txtylw}
    else
      local COLOR=${txtgrn}
    fi
    local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${NORMAL}"
    # The __git_ps1 function inserts the current git branch where %s is
    local GIT_PROMPT=`__git_ps1 "${txtwht}(${txtgrn}%s${txtwht}|${SINCE_LAST_COMMIT}${txtwht})"`
    echo ${GIT_PROMPT}
  fi
}

PS1="${txtgrn}\w $(git_prompt)${txtwht} > "
PS2='> '
PS4='+ '

# Aliases
if [ -f $HOME/.aliases ]; then
  source $HOME/.aliases
fi

# Rbenv with Homebrew
eval "$(rbenv init -)"

# Hub for github
eval "$(hub alias -s)"
