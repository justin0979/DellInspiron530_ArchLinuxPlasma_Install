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
alias c='conda'
alias ci='conda info'
alias ca='conda activate'

# add to PS1 to show which git branch you are on. 
# if directory doesn't have git, then nothing will show.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

HORBAR="—"
RFINGER="☞"
DFINGER="☟"
RARROW="→"
DRARR="↳"
URARR="↱"
INTEGRAL="∫"
THEREFORE="∴"
CGAMMA="ᒥ"
LFLOOR="ᒪ"
BOXDR="┌"

#PS1='[\u@\h \W]\$ '
#PS1='\w\n [\u@\h \W]\$ '
#PS1='\[\033[01;30m\]\w\n\[\033[01;32m\] [\u@\h \W]\$ '
#PS1="\[${GRAY}\]\w
#\[${LGRAY}\][\[${LGREEN}\]\u\[${LGRAY}\]@\[${LGREEN}\]\h \[${GRAY}\]\W\[${LGRAY}\]]\[${BLUE}\]\$ \[${NOCOL}\]"
#PS1="
#\[${LPURPLE}\]\w
#\[${LGRAY}\]→ \[${LGREEN}\]\u \[${LGRAY}\]\W\[${LGRAY}\]\[${BLUE}\]\$(parse_git_branch)\[${NOCOL}\] "
PS1="
\[${LGRAY}\]${URARR} \[${LBLUE}${INTEGRAL}\u = \[${LPURPLE}\]\w \[${LBLUE}+ c
\[${LGRAY}\]${DRARR} \[${LGREEN}\]\W\[${LGRAY}\]\[${BLUE}\]\$(parse_git_branch)\[${NOCOL}\] "

# add date and time to each history
export HISTTIMEFORMAT="%m.%d.%y %T "

export "PATH=$PATH:$HOME/.deno/bin"
export DENO_DIR=./deno_dir

export PATH=~/.local/bin:"$PATH"
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=/home/justin/.local/zephyr-sdk-0.12.4

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/justin/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/justin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/justin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/justin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

PATH="$HOME/.local/bin:$PATH"
