export PATH=/usr/local/bin:$PATH


# For https://github.com/robbert-vdh/yabridge (run Windows VSTs on Linux)
export PATH=$HOME/.local/share/yabridge:$PATH

# NPM and Yarn
if command -v npm &> /dev/null
then
  export PATH="$HOME/.npm-packages/bin:$PATH" # for npm and npm global packages
fi

if command -v yarn &> /dev/null
then
  export PATH="$PATH:`yarn global bin`" # for Yarn for global packages
fi

export PATH="$HOME/.emacs.d/bin:$PATH" # for Doom emacs

# for user installed binaries TODO move bin to .local/bin and remove this
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# For rbenv shims
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv &> /dev/null
then
  eval "$(rbenv init -)"
fi

# For pyenv https://github.com/pyenv/pyenv
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv >/dev/null
then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# kubectl
if command -v kubectl &> /dev/null
then
  # Enable autocompletion
  source <(kubectl completion zsh)
fi

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# if on linux setup linuxbrew
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux-specific commands
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
