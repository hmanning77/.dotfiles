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

### Path
if [ -d "$HOME/.local/bin" ]; then
    typeset -U path
    path=(~/.local/bin $path)
fi


###
### APPEARANCE
###

### Prompt
autoload -U colors && colors

# Minimal Prompt
local lastcmd="%(0?..%F{red}?:%? )"
local jobcount="%(1j.%F{green}J:%j .)"
local workingdir="%F{blue}%~%f"
PROMPT="
$lastcmd$jobcount$workingdir
>"
RPROMPT="%F{magenta}*%f"

# Box Prompt
#PROMPT="%{$fg_no_bold[blue]%}╒╡%{$fg_bold[black]%}%n%{$fg_no_bold[blue]%}╞═╡%{$fg_bold[black]%}%m%{$fg_no_bold[blue]%}╞═>%{$fg_bold[black]%} %~
#%{$fg_no_bold[blue]%}╘╡%(?.$.%?╞╡$)%{$reset_color%} "

### Colours

# Use base16 with 256 colour support
BASE16_SHELL="/home/hugh/.local/share/base16-shell/scripts/base16-atelier-forest.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Use syntax highlighting
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


###
### ALIASES
###
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias c='clear'

# Quick removable media management with udisks2
alias udm='udisksctl mount -b'
alias udu='udisksctl unmount -b'
alias uds='udisksctl status'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


###
### CUSTOM FUNCTIONS
###

# Configuration function deleted because it was messing with zsh
