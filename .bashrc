# ~/.bashrc: executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples.

# If not running interactively, don't do anything
echo "Sourcing .bashrc"

case $- in
    *i*) ;;
      *) return;;
esac

# Update PATH
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH

# Avoid duplicate lines in history and lines starting with space
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history length
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Enable globstar for recursive globbing
# shopt -s globstar

# Make less more friendly for non-text input files
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability; turned off by default to not distract the user
force_color_prompt=yes

# Function to get the IP address
get_ip() {
    if ip addr show tun0 &>/dev/null; then
        ip=$(ip -4 addr show tun0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    else
        ip=$(ip -4 addr show ens33 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    fi
    echo "$ip"
}

# Retrieve IP address once
IP=$(get_ip)

# Check for color support
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Set the prompt
if [ "$color_prompt" = yes ]; then
    PS1="\[\033[1;32m\]┌─[\[\033[1;37m\]${IP}\[\033[1;32m\]]─[\[\033[1;37m\]\u\[\033[1;32m\]@\[\033[01;34m\]\h\[\033[1;32m\]]─[\[\033[1;37m\]\w\[\033[1;32m\]]\n└──╼ [\[\e[01;33m\]x\[\e[01;32m\]]\\$ \[\e[0m\]"
else
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
    man() {
        env \
            LESS_TERMCAP_mb=$'\e[01;31m' \
            LESS_TERMCAP_md=$'\e[01;31m' \
            LESS_TERMCAP_me=$'\e[0m' \
            LESS_TERMCAP_se=$'\e[0m' \
            LESS_TERMCAP_so=$'\e[01;44;33m' \
            LESS_TERMCAP_ue=$'\e[0m' \
            LESS_TERMCAP_us=$'\e[01;32m' \
            man "$@"
    }
fi

unset color_prompt force_color_prompt

# Enable color support of ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'       # List files with color
    alias dir='dir --color=auto'     # List directories with color
    alias vdir='vdir --color=auto'   # List verbose directory content with color

    alias grep='grep --color=auto'   # Grep with color output
    alias fgrep='fgrep --color=auto' # Fixed-string grep with color output
    alias egrep='egrep --color=auto' # Extended grep with color output
fi

# Some more ls aliases
alias ll='ls -lh'           # Long listing with human-readable file sizes
alias la='ls -lha'          # Long listing with hidden files and human-readable sizes
alias l='ls -CF'            # List files in columns
alias em='emacs -nw'        # Open Emacs in terminal mode
alias dd='dd status=progress' # Show progress while using dd
alias _='sudo'              # Shorter alias for sudo
alias _i='sudo -i'          # Shorter alias for sudo -i

# Load custom aliases from ~/.bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features if not already enabled in /etc/bash.bashrc and /etc/profile
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
