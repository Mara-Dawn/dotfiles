ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
# Lines configured by zsh-newuser-install

# bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mara/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Keybinds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Load completionos
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

export EDITOR='nvim'
export VISUAL='nvim'

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Aliases
alias ls='exa --long --icons --group-directories-first'
alias l='exa --long --icons --tree --level=2 --group-directories-first'
alias ll='exa --long --icons --tree --level=3 --group-directories-first'
alias lsa='exa --all --long --icons --group-directories-first'
alias la='exa --all --long --icons --tree --level=2 --group-directories-first'
alias lla='exa --all --long --icons --tree --level=3 --group-directories-first'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(keychain --eval --quiet id_ed25519 ~/.ssh/id_ed25519)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(zoxide init zsh --cmd cd)"
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
eval "$(starship init zsh)"

# rest of zsh config above...

eval "$(starship init zsh)"

precmd_functions=(zvm_init "${(@)precmd_functions:#zvm_init}")
precmd_functions+=(set-long-prompt)
zvm_after_init_commands+=("zle -N zle-line-finish; zle-line-finish() { set-short-prompt }")

set-long-prompt() {
    PROMPT=$(starship prompt)
    RPROMPT=""
}
export COLUMNS=$(($COLUMNS + ($COLUMNS*0.1)))
set-short-prompt() {
    PROMPT="$(starship prompt --profile transient)"
    zle .reset-prompt 2>/dev/null # hide the errors on ctrl+c
}

zle-keymap-select() {
    set-short-prompt
}
zle -N zle-keymap-select

zle-line-finish() { set-short-prompt }
zle -N zle-line-finish

trap 'set-short-prompt; return 130' INT

# try to fix vi mode indication (not working 100%)
zvm_after_init_commands+=('
  function zle-keymap-select() {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = "block" ]]; then
      echo -ne "\e[1 q"
      STARSHIP_KEYMAP=vicmd
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} = "" ]] ||
         [[ $1 = "beam" ]]; then
      echo -ne "\e[5 q"
      STARSHIP_KEYMAP=viins
    fi
    zle reset-prompt
  }
  zle -N zle-keymap-select

  # Ensure vi mode is set
  zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
  }
  zle -N zle-line-init
')

