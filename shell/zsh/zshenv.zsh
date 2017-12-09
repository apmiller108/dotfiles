export PATH=/usr/local/bin:$PATH
# I have postres installed as an application. Makes it easier to update.
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
# MacPorts Installer addition on 2016-02-07_at_13:57:27: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="$HOME/.npm-packages/bin:$PATH" # for npm and npm global packages
export PATH="$PATH:`yarn global bin`" # for Yarn for global packages
# Build Environment for Angular projects
export BUILD_ENV=development
# added by Anaconda3 4.4.0 installer
export PATH="/Users/upgraydd/anaconda/bin:$PATH"
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$(brew --prefix qt@5.5)/bin:$PATH"
# For rbenv shims
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
