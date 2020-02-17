#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1='\w\n [\u@\h \W]\$ '
#PS1='\[\033[01;30m\]\w\n\[\033[01;32m\] [\u@\h \W]\$ '
PS1='\[\033[01;30m\]\w
\[\033[00m\][\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;32m\]\h \[\033[01;30m\]\W\[\033[00m\]]\[\033[0;34m\]\$ \[\033[00m\]'
