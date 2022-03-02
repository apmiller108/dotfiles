export PATH=/usr/local/bin:$PATH

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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# For rbenv shims
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv &> /dev/null
then
  eval "$(rbenv init -)"
fi

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# kubectl
if command -v kubectl &> /dev/null
then
  # Enable autocompletion
  source <(kubectl completion zsh)
fi
