export RIPGREP_CONFIG_PATH=~/.ripgreprc

alias g="git status"
alias ga="git add ."
alias gc="git commit -m ${1}"
alias gco="git checkout ${1} ${2}"
alias gd="git diff"
alias gdt="git difftool"
alias gmt="git mergetool"
alias gp="git push ${1} ${2}"
alias gpl="git pull ${1} ${2}"
alias grb="git rebase ${1} ${2}"
alias gs="git status"

alias h="history | fzf"

alias la="ls -al"
alias lf="ls -al | grep ${1}"
alias ll="ls -al"
alias lt="ls -al --sort=modified"

alias t="tmux"
alias tls="t ls"
alias tks="t kill-server"
alias tkill="t kill-session -t ${1}"
alias tso="t source-file ~/.tmux.conf"
alias tml="tmuxp load ."
alias tt="$EDITOR ~/.tmux.conf"

alias v="nvim"
alias y="yarn"
alias n="npm"

alias so="source ~/.zshrc"
alias zx="source ~/.zshrc"
alias zz="$EDITOR ~/.zshrc"

alias dops="docker ps -a"
alias dcd="docker-compose down"
alias dcu="docker-compose up"
alias dcb="docker-compose build"
alias doclr="docker container prune -f"
alias dcp="docker container prune -f"
alias dsp="docker system prune --volumes"

alias grh="git reset --hard"


setopt SHARE_HISTORY
setopt extended_glob
setopt prompt_subst
setopt auto_cd

stty -ixon

if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update
else
  source ~/.zplug/init.zsh
fi

# zplug "lib/history",                       from:"oh-my-zsh"
# zplug "plugins/autojump",                  from:"oh-my-zsh"
# zplug "plugins/shrink-path",               from:"oh-my-zsh"
# zplug "zdharma-continuum/fast-syntax-highlighting",  defer:3
# zplug "zsh-users/zsh-autosuggestions",     defer:3
# zplug "zsh-users/zsh-completions",     defer:3
# # zplug "zsh-users/zsh-history-substring-search" defer:3
#
# zplug "BurntSushi/ripgrep",                defer:3, from:"gh-r", as:"command", use:"*darwin*", rename-to:"rg"
# # zplug "junegunn/fzf-bin",                  defer:3, from:"gh-r", as:"command", use:"*darwin*", rename-to:"fzf"
# zplug "asdf-vm/asdf",                      defer:3
#
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     else
#         echo
#     fi
# fi
#
# zplug load


# set autoload path
fpath=(~/zsh "${fpath[@]}")

# move cursor to end of line after history search completion
autoload -Uz history-search-end cani vmc vmi lps kp fp cani bip bup bcp tmuxify utils ll lx

# every time we load .zshrc, ditch duplicate path entries
typeset -U PATH fpath



bindkey '^e' autosuggest-accept
bindkey '^x' autosuggest-execute

# search history using already written command string
zle -N history-beginning-search-backward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end

zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[B" history-beginning-search-forward-end

### toggle vim in "dev" mode (see .vimrc: $VIM_DEV)
# allows me to easily load plugins from local directory rather than ~/.vim/bundle
vdm() {
if [[ "$VIM_DEV" == "1" ]] then
  export VIM_DEV=0
else
  export VIM_DEV=1
fi

echo "vdm: $VIM_DEV"
}

# To install useful key bindings and fuzzy completion:
# $(brew --prefix)/opt/fzf/install

# tmuxify

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS="--height=50% --min-height=15 --reverse"
export FZF_DEFAULT_OPTS=' --height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

alias gll='fzf_git_log'

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


bindkey -v # Vim mode


if [[ ~/.local.zsh ]]; then
source ~/.local.zsh
fi


eval "$(starship init zsh)"


export PATH="$PATH:`yarn global bin`"




# zoxide
eval "$(zoxide init zsh)"
# export _ZO_DATA_DIR = "$HOME/.local/share/"
export _ZO_ECHO=1
# zoxide

# asdf
. $HOME/.asdf/asdf.sh

# asdf Ruby
# https://hellomax.me/tips/2023/03/11/how-to-install-recent-ruby-with-asdf-on-m1.html
export RUBY_CONFIGURE_OPTS="--with-zlib-dir=$(brew --prefix zlib) \
--with-openssl-dir=$(brew --prefix openssl@3) \
--with-readline-dir=$(brew --prefix readline) \
--with-libyaml-dir=$(brew --prefix libyaml)"
# asdf


