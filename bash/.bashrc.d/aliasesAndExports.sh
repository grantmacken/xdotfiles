#!/bin/bash
GIT_USER="$( git config --get user.name )"

alias dotfiles-reload='source $HOME/.bashrc'
alias fold="fold -s"
#alias docker=podman
#alias mk="make --no-builtin-rules --warn-undefined-variables --silent --no-print-directory"
export ERL_AFLAGS="+pc unicode -kernel shell_history enabled"

REBAR_BIN=$HOME/.cache/rebar3/bin
if [[ ! "$PATH" == *${REBAR_BIN}* ]]; then
  export PATH="$PATH:${REBAR_BIN}"
fi

CARGO_BIN=$HOME/.cargo/bin
if [[ ! "$PATH" == *${CARGO_BIN}* ]]; then
  export PATH="$PATH:${CARGO_BIN}"
fi

#export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
# export VISUAL='nvr --remote-wait-silent'
export EDITOR=nvim
if [ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]; then
    echo "\$XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) not writable. Setting to /tmp." >&2
    XDG_RUNTIME_DIR=/tmp
fi
export XDG_RUNTIME_DIR

# NODE 
export NODE_PATH=$HOME/.local/npm/lib/node_modules
export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/config
# export NPM_CONFIG_CACHE=$HOME/.cache/npm
# global npm
NPM_BIN=$HOME/.local/npm/bin
if [[ ! "$PATH" == *${NPM_BIN}* ]]; then
  export PATH="$PATH:${NPM_BIN}"
fi
NPM_CONFIG_PREFIX=$HOME/.local/npm/bin


# make sure we have a local bin on path
LOCAL_BIN=/usr/local/bin
if [[ ! "$PATH" == *${LOCAL_BIN}* ]]; then
  export PATH="$PATH:${LOCAL_BIN}"
fi
export PATH=$PATH:$(go env GOPATH)/bin

# export GOPATH=$HOME/go
# git controlled project development
# if we have a user name set a PROJECTS folder
if [ -n "${GIT_USER}" ]; then
  export GIT_USER="${GIT_USER}"
  
  PROJECTS="$HOME/projects/${GIT_USER}"
  alias p="cd $PROJECTS"
  export PROJECTS="${PROJECTS}"
#
# NODE_BIN=${PROJECTS}/node_modules/.bin
# if [[ ! "$PATH" == *${NODE_BIN}* ]]; then
#   export PATH="$PATH:${NODE_BIN}"
# fi

  #LEDGER_FILE=${PROJECTS}/accounts/main.ledger
  #export LEDGER_FILE="${LEDGER_FILE}"
  #LEDGER_PRICE_DB=${PROJECTS}/accounts/pricedb.ledger
  #export LEDGER_PRICE_DB="${LEDGER_PRICE_DB}"

  #LEDGER_INIT_FILE=~/.ledgerrc
  #export LEDGER_INIT_FILE="${LEDGER_INIT_FILE}"
  # Equivalent to %Y-%m-%d (the ISO 8601 date format). (C99
  #LEDGER_DATE_FORMAT=%F
  #export LEDGER_DATE_FORMAT="${LEDGER_DATE_FORMAT}"
fi
