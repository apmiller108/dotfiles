export PATH=/usr/local/bin:$PATH
# I have postres installed as an application. Makes it easier to update.
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
# MacPorts Installer addition on 2016-02-07_at_13:57:27: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.npm-packages/bin:$PATH" # for npm and npm global packages
export PATH="$PATH:`yarn global bin`" # for Yarn for global packages
# Build Environment for Angular projects
export BUILD_ENV=development
# added by Anaconda3 4.4.0 installer
export PATH="/Users/upgraydd/anaconda/bin:$PATH"
