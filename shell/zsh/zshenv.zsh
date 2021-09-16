export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.npm-packages/bin:$PATH" # for npm and npm global packages
export PATH="$PATH:`yarn global bin`" # for Yarn for global packages
export PATH="$HOME/.emacs.d/bin:$PATH" # for Doom emacs
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH" # for tar
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# For rbenv shims
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
