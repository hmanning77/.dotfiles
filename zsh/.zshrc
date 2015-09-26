# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hugh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

###
### ENVIRONMENT
###

# Add local bin to path
if [ -d "$HOME/.local/bin" ]; then
    typeset -U path
    path=(~/.local/bin $path)
fi

# Manually fix tmux ignoring 256 color urxvt
if [[ $(hostname) == wanderer && $TERM == screen ]]; then
    export TERM=screen-256color;
fi

###
### THEME
###

# Let's try powerline
if [[ $(hostname) == "hugh-pc" ]]; then
    source "/usr/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh"
elif [[ $(hostname) == "wanderer" ]]; then
    source "$HOME/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    # test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

###
### ALIASES
###
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias udm='udisksctl mount -b'
alias udu='udisksctl unmount -b'
alias uds='udisksctl status'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

source "$HOME/Software/Source/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
