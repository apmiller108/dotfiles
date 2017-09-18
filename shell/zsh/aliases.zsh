#                              _ _                     
#                         __ _| (_) __ _ ___  ___  ___ 
#                        / _` | | |/ _` / __|/ _ \/ __|
#                       | (_| | | | (_| \__ \  __/\__ \
#                        \__,_|_|_|\__,_|___/\___||___/

# Git
alias g="git status"
alias gaa="git add ."
alias gc="git commit"
alias gb="git branch"
alias gco="git checkout"

# Heroku toolbelt
alias hrrc="heroku run rails c"
alias hlpd="heroku local -f Procfile.dev"
alias he="heroku"

# Docker
alias dc="docker-compose"
alias dcr="docker-compose run"
alias cleandocker="sh ~/development/shell/clean-docker.sh"
# alias dpost="docker exec -it `docker ps | grep -oE '\w+postgres_1$'` psql -U postgres"
alias dss="docker-sync-stack"

# Interactive and verbose for saftey
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# Elixir and Phoenix
alias el="elixir"
alias mps="mix phoenix.server"

# The rest
alias o="open ."
alias bex="bundle exec"
alias ls="ls -F"
alias df="dh -h"
alias emacs="ec"
alias e="emacsclient --no-wait"
