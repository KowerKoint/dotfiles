function powerline_precmd() {
    PS1="$(~/.local/bin/powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi 
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
ZSH_HIGHLIGHT_STYLES[alias]=fg=green
ZSH_HIGHLIGHT_STYLES[builtin]=fg=green
ZSH_HIGHLIGHT_STYLES[function]=fg=green
ZSH_HIGHLIGHT_STYLES[command]=fg=green
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_prefix]=underline
ZSH_HIGHLIGHT_STYLES[path_approx]=fg=yellow,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=white
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=white
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=white
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=white
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=white
ZSH_HIGHLIGHT_STYLES[assign]=none

export EDITOR=nvim
export PATH="$HOME/bin:$HOME/go/bin:$PATH"

function mc() {
    mkdir $argv && cd $argv
}

function open() {
    xdg-open $argv &
}

setopt auto_cd
function chpwd() {
    lsd -a
}

function cmdedit() {
    nvim $(which $argv)
}

alias ls='lsd'
alias ll='lsd -alF'
alias cat='nkf -w'
alias ..2='../..'
alias ..3='../../..'
alias ..4='../../../..'
alias ..5='../../../../..'
alias gc='git clone'
alias agi='sudo apt install'
alias agr='sudo apt remove'
alias agu='sudo apt update && sudo apt upgrade'
alias tweet='tweet.sh post'
alias e='exit'
