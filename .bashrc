# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=㉿
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        prompt_color='\[\033[;94m\]'
        info_color='\[\033[1;31m\]'
        # Skull emoji for root terminal
        #prompt_symbol=💀
    fi
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] ';;
        oneline)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ ';;
        backtrack)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ';;
    esac
    unset prompt_color
    unset info_color
    unset prompt_symbol
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
    # Add directory path to below
    alias mkpyf='touch __init__.py __main__.py models.py views.py'
    
    # Fuzzyfind search man pages: not working
    # alias manfzf='man -k . | fzf --preview='man {}''

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# TODO: Move aliases to separate file
# Then alias opening that file to something like 'basha'

# --- h hhell Aliases ---

# Shell shortcuts
mkcd () {
  mkdir -p "$1" && cd "$1" || return
}

add_git_ssh_key() {
    if ssh-add -l &>/dev/null; then
        :
    else
        ssh-add ~/.ssh/id_git &> /dev/null
    fi
}


# TODO: Scripts to expand nlf and nlv, currently doesn't work with pipes

# Split a file by delimiter into separate lines
# Usage: nld <file> <delimiter>
nlf () {
  cat "$1" | tr "$2" '\n'
}

# Split a variable by delimiter (like $PATH) into separate lines
# Usage: nlf <variable> <delimiter>
nlv () {
  echo "$1" | tr "$2" '\n'
}

# Neovim shortcuts
alias nv="nvim"

# Python shortcuts
alias ptp="python3.13 -m ptpython"
alias py="python3.13"
alias actpv="source venv/bin/activate"
alias mkpv="python3.13 -m venv .venv"
alias pfr="pip freeze > requirements.txt"

# Config shortcuts
alias nvc="nvim ~/.config/nvim/init.lua"
alias bashc="nvim ~/.bashrc"
alias ssa='eval "$(ssh-agent -s)"'

# Manual shortcuts: This does not currently work
# Need to interpolate the argument into the single quotes somehow
alias nvman="nvim '+Man'"

# Browse manual pages
fzman () {
  local cmd
  cmd=$(man -k . | fzf | awk '{print $1}')
  [ -n "$cmd" ] && man "$cmd"
}

# TODO: Alias this to remove multiple spaces from a file and write a new one
# 
# Script could be like this:
# mv text_processing.sh > text_processing_temp.sh
# cat -s text_processing_temp.sh > text_processing.sh-s old.py > new.py

# Fuzzy find man pages
# alias fman="compgen -c | fzf | xargs man"

# Set Proxmox API and SSH credentials
export SSH_USERNAME="root"
export SSH_PASSWORD="kelimutu"
export PM_USERNAME="root@pam"
export PM_PASSWORD="kelimutu"

export PATH=${HOME}/tools/vim/bin:$PATH
export PATH=$PATH:~/bin

# Created by `pipx` on 2024-01-05 07:44:41
export PATH="$PATH:/home/kyle/.local/bin"

# From linux CL book

# Sets the umask to solve the problem with
# shared directories we discussed in Chapter 9
umask 0002


# Causes the shell’s history recording
# feature to ignore a command if the same
# command was just recorded.
export HISTCONTROL=ignoredups

# Increase history size
export HISTSIZE=1000

alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias py='python3'
source '/home/kyle/.bash_completions/typer.sh'

add_git_ssh_key

export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
