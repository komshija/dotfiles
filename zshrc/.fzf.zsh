# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tmadevelop/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tmadevelop/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/tmadevelop/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/tmadevelop/.fzf/shell/key-bindings.zsh"
