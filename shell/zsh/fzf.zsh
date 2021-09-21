# fzf is a general-purpose command-line fuzzy finder.
# https://github.com/junegunn/fzf
# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion and Key bindings
# --------------------------------

# MacOS
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

if test -f "/usr/local/opt/fzf/shell/key-bindings.zsh"; then
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi

# Ubuntu
if test -f "/usr/share/doc/fzf/examples/key-bindings.zsh"; then
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
  source "/usr/share/doc/fzf/examples/completion.zsh"
fi
