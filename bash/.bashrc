# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ $HOME/.local/bin:$HOME/bin: ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
# User specific aliases and functions
# shellcheck source=/dev/null
			. "$rc"
		fi
	done
fi

unset rc

# gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/gmack/projects/google-cloud-sdk/path.bash.inc' ]; then . '/home/gmack/projects/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/gmack/projects/google-cloud-sdk/completion.bash.inc' ]; then . '/home/gmack/projects/google-cloud-sdk/completion.bash.inc'; fi

export CLOUDSDK_PYTHON=/usr/bin/python3.9


# User specific environment and startup programs
# source "/home/gmack/projects/emsdk/emsdk_env.sh"

. "$HOME/.cargo/env"
