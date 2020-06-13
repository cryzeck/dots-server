#
#  ███████╗███████╗██╗  ██╗██████╗  ██████╗
#  ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#    ███╔╝ ███████╗███████║██████╔╝██║
#   ███╔╝  ╚════██║██╔══██║██╔══██╗██║
#  ███████╗███████║██║  ██║██║  ██║╚██████╗
#  ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#


# Setup plugins
source ~/.zsh_plugins.sh

# Set vi mode
bindkey -v

# Misc config
setopt auto_cd  # cd by typing dir name
unsetopt correct_all # autocorrect commands
setopt auto_list # auto list choices on ambigous completion
setopt auto_menu #auto use menu completion
setopt always_to_end # move cursor to end if word had one match

# Misc Style
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# Setup command history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

# Enable autocompletion 
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
zmodload -i zsh/complist

# Setup fzf keybindings
if [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/key-bindings.zsh"
  export FZF_CTRL_R_OPTS="--reverse"
fi

# Some aliases
alias SS="sudo systemctl"
alias v="nvim"
alias sv="sudo nvim"
alias ka="killall"
alias g="git"
alias mkd="mkdir -pv"
alias vim="nvim"


# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"

vg() {
  local file
  file="$(mloc | fzf)"

  cd "$file"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
