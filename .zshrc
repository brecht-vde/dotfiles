# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# source the zinit file
source "${ZINIT_HOME}/zinit.zsh"

# Install powerlevel 10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# load completions
autoload -U compinit && compinit

# recommended for replaying cached completions
zinit cdreplay -q

# history settings
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

# disable beeps
unsetopt beep

# disable case sensitive auto completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# auto completion with colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# fzf as default auto completion
zstyle ':completion:*' menu no
# preview auto completion results
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# make previews work with zoxide
zstyle ':fzf-tab:complete:cd:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# do some fzf stuff
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

# aliases
alias ls='ls --color'
alias code='code-insiders'

# update path
export PATH=$PATH:/user/local/go/bin
export PATH=$PATH:/home/brecht/.local/bin

#change colors for fzf_oxide
export FZF_DEFAULT_OPTS="--color=bg:#bcbcbc"
export _ZO_FZF_OPTS="$_FZF_DEFAULT_OPTS --select-1"

# fuzzy finder shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
