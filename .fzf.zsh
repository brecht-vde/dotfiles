# Setup fzf
# ---------
if [[ ! "$PATH" == */home/brecht/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/brecht/.fzf/bin"
fi

source <(fzf --zsh)
