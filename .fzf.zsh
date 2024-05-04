# Setup fzf
# ---------
if [[ ! "$PATH" == */home/je4n/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/je4n/.fzf/bin"
fi

eval "$(fzf --zsh)"
