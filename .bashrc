#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

NOCOL='\033[00m'
GREEN='\033[00;32m'
#LGREEN='\033[01;32m'
LGREEN='\e[38;5;119m'
#BLUE='\033[00;34m'
BLUE='\e[34m'
LBLUE='\033[01;34m'
GRAY='\033[01;30m'
LGRAY='\033[00;37m'
PURPLE='\e[35m'
#LPURPLE='\033[01;35m'
LPURPLE='\e[38;5;104m'
CYAN='\033[00;36m'
LCYAN='\033[01;36m'

BLINK='\e[5m'
NOBLINK='\e[25m'

alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -lah'
alias cls='clear && ls'
alias dr='deno run'
alias k='kubectl'

# add to PS1 to show which git branch you are on. 
# if directory doesn't have git, then nothing will show.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#PS1='[\u@\h \W]\$ '
#PS1='\w\n [\u@\h \W]\$ '
#PS1='\[\033[01;30m\]\w\n\[\033[01;32m\] [\u@\h \W]\$ '
#PS1="\[${GRAY}\]\w
#\[${LGRAY}\][\[${LGREEN}\]\u\[${LGRAY}\]@\[${LGREEN}\]\h \[${GRAY}\]\W\[${LGRAY}\]]\[${BLUE}\]\$ \[${NOCOL}\]"
#PS1="
#\[${LPURPLE}\]\w
#\[${LGRAY}\]→ \[${LGREEN}\]\u \[${LGRAY}\]\W\[${LGRAY}\]\[${BLUE}\]\$(parse_git_branch)\[${NOCOL}\] "
PS1="
\[${LPURPLE}\]\w
\[${LGRAY}\]→ \[${LGREEN}\]\W\[${LGRAY}\]\[${BLUE}\]\$(parse_git_branch)\[${NOCOL}\] "

export "PATH=$PATH:$HOME/.deno/bin"
export DENO_DIR=./deno_dir

export PATH=~/.local/bin:"$PATH"
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=/home/justin/.local/zephyr-sdk-0.11.4
