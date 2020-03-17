#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

NOCOL='\033[00m'
GREEN='\033[00;32m'
LGREEN='\033[01;32m'
BLUE='\033[00;34m'
LBLUE='\033[01;34m'
GRAY='\033[01;30m'
LGRAY='\033[00;37m'


alias ls='ls --color=auto'
alias ll='ls -lah'

#PS1='[\u@\h \W]\$ '
#PS1='\w\n [\u@\h \W]\$ '
#PS1='\[\033[01;30m\]\w\n\[\033[01;32m\] [\u@\h \W]\$ '
PS1="\[${GRAY}\]\w
\[${LGRAY}\][\[${LGREEN}\]\u\[${LGRAY}\]@\[${LGREEN}\]\h \[${GRAY}\]\W\[${LGRAY}\]]\[${BLUE}\]\$ \[${NOCOL}\]"
