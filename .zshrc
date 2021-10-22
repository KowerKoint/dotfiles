#PATHを入れまくる
export PATH="$PATH:$HOME/bin:$HOME/go/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/.gem/ruby/3.0.0/bin"

#WSL独自
if [[ "$(uname -r)" == *microsoft* ]]; then
  fix_wsl2_interop() {
      for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
          if [[ -e "/run/WSL/${i}_interop" ]]; then
              export WSL_INTEROP=/run/WSL/${i}_interop
          fi
      done
  }
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi

#powerline:ターミナルの見た目
#https://github.com/b-ryan/powerline-shell
function powerline_precmd() {
  PS1="$(powerline-shell --shell zsh $?)"
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

#zplug(Zshのプラグインインストーラ)
#https://github.com/zplug/zplug
source ~/.zplug/init.zsh

#シンタックスハイライト
#https://github.com/zsh-users/zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#Tab補完をめっちゃ強くする
#https://github.com/zsh-users/zsh-completions
zplug "zsh-users/zsh-completions"
#雑なcdを通す
#https://github.com/b4b4r07/enhancd
zplug "b4b4r07/enhancd", use:init.sh

#起動時にzplugの未インストールプラグイン確認
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

#enhancdの設定
export ENHANCD_FILTER=peco #検索機能はpecoを使用
export ENHANCD_DISABLE_DOT=1 #"cd .."の挙動は通常通りにする
export ENHANCD_DISABLE_HOME=1 #"cd"の挙動は通常通りにする

#コマンド履歴を保存
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

setopt inc_append_history #履歴をインクリメンタルに追加する
setopt share_history #コマンド履歴を他セッションと共有

#cdrコマンドの設定 よくわからん
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

#色の設定 よくわからん
eval `dircolors -b`
eval `dircolors ${HOME}/.dircolors`

autoload colors
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

export LESS='-R'

export MANPAGER='less -R'
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;33m") \
    LESS_TERMCAP_md=$(printf "\e[1;36m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
  }

#環境変数
export BROWSER=firefox
export EDITOR=nvim

#mkdirとcdを一度に行う関数
function mc() {
  mkdir $argv && cd $argv
}

#デフォルトのアプリで開く WSLの場合はWindows側で開く
function open() {
  if [[ -e /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
    cmd.exe /c start $argv
  else
    xdg-open $argv &
  fi
}

setopt auto_cd #ディレクトリ名を直接打つだけでcdする

#コマンドのスクリプトをnvimで開く
function cmdedit() {
  nvim $(which $argv)
}

#我がメチャクチャなエイリアス集！
alias ls='lsd'
alias ll='lsd -alF'
alias ..2='../..'
alias ..3='../../..'
alias ..4='../../../..'
alias ..5='../../../../..'
alias gc='git clone'
alias agi='sudo apt install'
alias agr='sudo apt remove'
alias agu='sudo apt update && sudo apt upgrade'
alias e='exit'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

#Ctrl+Rでコマンドの履歴を検索できる
function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

#Ctrl+Xで過去の移動したディレクトリを検索できる
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^x' peco-cdr

#pipの補完
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
    COMP_CWORD=$(( cword-1 )) \
    PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip3

#npmの補完
if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
      COMP_LINE="$COMP_LINE" \
      COMP_POINT="$COMP_POINT" \
      npm completion -- "${words[@]}" \
      2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
      COMP_LINE=$BUFFER \
      COMP_POINT=0 \
      npm completion -- "${words[@]}" \
      2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
      COMP_LINE="$line" \
      COMP_POINT="$point" \
      npm completion -- "${words[@]}" \
      2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
