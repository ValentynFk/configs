TITLE="\033]0;Title\a"
PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$\[$TITLE\]"

# Configure editors
alias e='vim'
alias vi='vim'
export EDITOR=vim 
export CSCOPE_EDITOR=vim
export TERM=xterm-256color
export LD_LIBRARY_PATH=/lib:/usr/lib
export PATH="/usr/lib/ccache:$PATH"

# Some legacy stuff
alias quit='exit'
alias whereami='pwd'
#alias tmux='TERM=screen-256color tmux'
alias home='pushd . > /dev/null && cd ~'
alias work='pushd . > /dev/null && cd /path/to/work'
