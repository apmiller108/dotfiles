#                              _ _
#                         __ _| (_) __ _ ___  ___  ___
#                        / _` | | |/ _` / __|/ _ \/ __|
#                       | (_| | | | (_| \__ \  __/\__ \
#                        \__,_|_|_|\__,_|___/\___||___/

# Git
alias g="git status"
alias gaa="git add ."
alias gc="git commit"
alias gb="git branch | cat"
alias gco="git checkout"
alias gl="git log --graph --pretty=format:\"%C(yellow)%h%C(reset) %G? %C(bold blue)%an%C(reset) %s%C(bold cyan)%d%C(reset) %C(green)%cr.%C(reset)\""

# Docker
alias de='docker exec -e COLUMNS="$(tput cols)" -e LINES="$(tput lines)" -it'
alias dgo='docker run -e COLUMNS="$(tput cols)" -e LINES="$(tput lines)" -it --rm -p 4567:4567 -v "$PWD":/app -w "/app"'
alias dgoruby3='dgo ruby:3 bash'
alias da='docker attach'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Command}}\t{{.Image}}"'
alias dep='de postgres psql -U admin'
alias dstopall='docker stop $(docker ps -aq)'

# Docker Compose
alias dc="docker compose"

# HTTP server
alias dserve='docker run --rm -p 8080:80 --name="myapache" -v "$PWD":/usr/local/apache2/htdocs/ httpd'

# Interactive and verbose for saftey
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# Emacs
alias spacemacsbg="emacs --with-profile spacemacs --daemon=spacemacs"
alias spacemacsc="emacsclient --create-frame --no-wait --socket-name=spacemacs"
alias sm="emacsclient --socket-name=spacemacs -nw"
alias spacemacs="emacs --with-profile spacemacs -nw"
alias spacemacskill="emacsclient --socket-name=spacemacs -e '(kill-emacs)'"
alias dm="emacs --with-profile doom -nw"
alias doombg="dm --daemon=doom"
alias doomc="emacsclient --create-frame --no-wait --socket-name=doom"
alias doom="doombg && doomc"
alias doomkill="emacsclient --socket-name=doom -e '(kill-emacs)'"
alias eksigusr2="ps aux | grep -ie emacs | grep -v grep | awk '{print $2}' | xargs kill -SIGUSR2"

# The rest
alias ls="ls -alhF"  #include dotfiles, list files in "long format", human readable file sizes, denote dirs, symlinks, executables, etc
alias myaliases="cat ~/dotfiles/shell/zsh/aliases.zsh"
alias sourcez="source ~/.zshrc"
alias rpw="systemctl --user restart wireplumber pipewire pipewire-pulse"

# Project dev

# TMP
alias twd="dc exec -it app"
alias twt="dc exec app rspec"
alias tdd="dc exec -it database psql -U postgres -d tmp_development"
alias twa="dc attach app"
