#                                 _            _   _
# _ __  _ __ ___  _ __ ___  _ __ | |_ __ _ ___| |_(_) ___
#| '_ \| '__/ _ \| '_ ` _ \| '_ \| __/ _` / __| __| |/ __|
#| |_) | | | (_) | | | | | | |_) | || (_| \__ \ |_| | (__
#| .__/|_|  \___/|_| |_| |_| .__/ \__\__,_|___/\__|_|\___|
#|_|                       |_|

# comes from the miloshadzic theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{$fg[cyan]%}%2~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}⇒%{$reset_color%} '

export PS1="$([[ ! -z "${UPTERM_ADMIN_SOCKET}"  ]] && echo -e  "\033[0;31mupterm ")$PS1"
