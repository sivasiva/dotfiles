# -------------------------------------------------------------------
# REF: https://www.reddit.com/r/zsh/comments/qqb57q/comment/hjzaiwg/
# -------------------------------------------------------------------
if [[ ! -e ~/.zsh/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

if [[ ! -e ~/.zsh/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
fi

if [[ ! -e ~/.zsh/pure ]]; then
  git clone https://github.com/sindresorhus/pure.git ~/.zsh/pure
fi

autoload -Uz compinit && compinit

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# PS1='%F{green}%n@%m%f %F{blue}%~%f%# '

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export EDITOR="nvim"
export DISABLE_AUTO_TITLE='true'
export PNPM_HOME=$HOME/Library/pnpm
export PATH=$PNPM_HOME:$PATH

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias clr="clear"
#alias doop="open \"http://$(docker-machine ip):3000/clients/new\""
alias dcd="docker-compose down --remove-orphans --volumes"
alias dcu="docker-compose up --build"
alias dcud="docker-compose up -d"
alias doclr="docker ps --no-trunc -aqf 'status=exited' | xargs docker rm -v"
alias doim="docker images"
alias dops="docker ps -a"
alias dormi="docker images | grep -oE ' <none>\s*\w*' | grep -oE '\w*$' | xargs -n 1 docker rmi"
alias dossh="$DKE /bin/bash"
alias dsp='docker system prune'
alias dv='docker volume ls'
alias dvclr='docker volume rm $(docker volume ls -qf dangling=true)'
alias l='ls -al'
alias lh='ls -d .*'                      # show hidden files/directories only
alias ll='ls -FGlAhp'
alias ls='ls -GFh'                       # Colorize output, add file type indicator, and put sizes in human readable format
alias lsd='ls -aFhlG'
alias npm="pnpm"
alias n="npm"
alias soz="source ~/.zshrc"
alias t="tmux"
alias tkill="tmux kill-server"
alias tks="tmux kill-server"
alias tls="t ls"
alias tmux="tmux -2" # Fix Tmux colors
alias tso="t source-file ~/.tmux.conf"
alias v="nvim"
alias y="yarn"

# alias tml="cd ~/projects/ && tmuxp load ."
tml() {
  clear
  if [ -f .tmuxp.yml ]; then
    tmuxp load .tmuxp.yml
  else
    tmuxp load ~/projects/.tmuxp.yml
  fi
}

# https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
fzf_find_edit() {
  local file=$(
    fzf --no-multi --preview 'bat --color=always --line-range :500 {}'
    )
  if [[ -n $file ]]; then
      $EDITOR $file
  fi
}

alias ffe='fzf_find_edit'
alias e='fzf_find_edit'

fzf_grep_edit(){
  if [[ $# == 0 ]]; then
      echo 'Error: search term was not provided.'
      return
  fi
  local match=$(
    rg --color=never --line-number "$1" |
      fzf --no-multi --delimiter : \
          --preview "bat --color=always --line-range {2}: {1}"
    )
  local file=$(echo "$match" | cut -d':' -f1)
  if [[ -n $file ]]; then
      $EDITOR $file +$(echo "$match" | cut -d':' -f2)
  fi
}

alias fge='fzf_grep_edit'
alias f='fzf_grep_edit'

fzf_kill() {
  local pids=$(
    ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f3
    )
  if [[ -n $pids ]]; then
      echo "$pids" | xargs kill -9 "$@"
  fi
}

alias fkill='fzf_kill'

fzf_git_add() {
  local files=$(git ls-files --modified | fzf --ansi)
  if [[ -n $files ]]; then
      git add --verbose $files
  fi
}

alias gadd='fzf_git_add'

fzf_git_log() {
  local commits=$(
    git ll --color=always "$@" |
      fzf --ansi --no-sort --height 100% \
          --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                      xargs -I@ sh -c 'git show --color=always @'"
    )
  if [[ -n $commits ]]; then
      local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
      git show $hashes
  fi
}

alias fgl='fzf_git_log'

fzf_git_log_pickaxe() {
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local commits=$(
      git log --oneline --color=always -S "$@" |
        fzf --ansi --no-sort --height 100% \
            --preview "git show --color=always {1}"
      )
    if [[ -n $commits ]]; then
        local hashes=$(printf "$commits" | cut -d' ' -f1 | tr '\n' ' ')
        git show $hashes
    fi
}

alias glS='fzf_git_log_pickaxe'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/local.zsh ] && source ~/local.zsh

# export MISE_DEBUG=1 
# export MISE_TRACE=1 
eval "$(/Users/siva2025/.local/bin/mise activate zsh)"
