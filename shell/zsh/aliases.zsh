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

# Heroku toolbelt
alias hrrc="heroku run rails c"
alias hlpd="heroku local -f Procfile.dev"
alias he="heroku"
alias hr="heroku run"

# Docker
alias dc="docker-compose"
alias dcr="docker-compose run"
alias de='docker exec -e COLUMNS="$(tput cols)" -e LINES="$(tput lines)" -ti'
alias da='docker attach'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Command}}\t{{.Image}}"'
alias dep='de postgres psql -U admin'
alias dl='docker logs'
alias dstartall='docker start $(docker ps -a -q -f status=exited)'
alias dstopall='docker stop $(docker ps -aq)'
alias drpuml='docker run -d -p 3333:8080 --name plant_uml plantuml/plantuml-server:jetty'

# Interactive and verbose for saftey
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# Elixir and Phoenix
alias el="elixir"
alias mps="mix phoenix.server"
alias ism="iex -S mix"

# Emacs
alias spacemacs="emacs --with-profile spacemacs"
alias spacemacsbg="spacemacs --daemon=spacemacs"
alias spacemacsc="emacsclient --create-frame --no-wait --socket-name=spacemacs"
alias emacskill="emacsclient -e '(kill-emacs)'"
alias doom="emacs --with-profile doom"

# The rest
alias bex="bundle exec"
alias brspec="bundle exec rspec"
alias ls="ls -F"
alias df="dh -h"
alias ngrok="~/ngrok"
alias myaliases="cat ~/dotfiles/shell/zsh/aliases.zsh"
alias sourcez="source ~/.zshrc"
