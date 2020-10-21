# Debug
#zmodload zsh/zprof

##########################################################################################

###########
#  ZSHRC  #
###########

export ZSH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH_CONFIG/custom"

if [[ "$TERM" != 'linux' ]]; then
    ZSH_THEME='powerlevel10k/powerlevel10k'
fi

#CASE_SENSITIVE="true"
#HYPHEN_INSENSITIVE="true"
#DISABLE_AUTO_UPDATE="true"
UPDATE_ZSH_DAYS=7
#DISABLE_LS_COLORS="true"
#DISABLE_AUTO_TITLE="true"
#ENABLE_CORRECTION="true"
#COMPLETION_WAITING_DOTS="true"
#DISABLE_UNTRACKED_FILES_DIRTY="true"
#HIST_STAMPS="yyyy-mm-dd"


#############
#  PROFILE  #
#############

[[ -f "$HOME/.zprofile" ]] \
    && source "$HOME/.zprofile"


#####################
#  PLUGIN SETTINGS  #
#####################

# bgnotify settings
bgnotify_threshold=2    ## set your own notification threshold
bgnotify_formatted() {
    ## $1=exit_status, $2=command, $3=elapsed_time
    [[ $1 -eq 0 ]] && title="Zsh" || title="Zsh (fail)"
    bgnotify "$title (${3}s)" "$2"
}

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-syntax-highlighting
    zsh-completions
    zsh-autosuggestions
    command-not-found
    bgnotify
    git
    docker
    docker-compose
    heroku
    kubectl
)

# # Native plugins
# plugins=(
#     command-not-found
#     colorize
#     bgnotify
# )
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Remove plugins if in tty
[[ "$TERM" = 'linux' ]] \
    && plugins=("${(@)plugins:#zsh-autosuggestions}")

# Completions
[[ -f "$ZSH_CONFIG/completion.zsh" ]] \
    && source "$ZSH_CONFIG/completion.zsh"

# Oh-My-Zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] \
    && source "$ZSH/oh-my-zsh.sh"


########################
#  USER CONFIGURATION  #
########################

# export MANPATH="/usr/local/man:$MANPATH"

export LC_ALL=en_US.UTF-8                                                                                  
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="$HOME/.ssh/rsa_id"


############
#  CUSTOM  #
############

# Customize p10k theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$ZSH_CONFIG/p10k.zsh" ]] || source "$ZSH_CONFIG/p10k.zsh"

# Zsh options
#setopt COMPLETE_ALIASES
setopt HIST_IGNORE_SPACE
setopt NO_AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST

# No scrolllock
stty -ixon

# Highlighting
[[ -f "$ZSH_CONFIG/highlight.zsh" ]] \
    && source "$ZSH_CONFIG/highlight.zsh"

# Aliases
[[ -f "$ZSH_CONFIG/alias.zsh" ]] \
    && source "$ZSH_CONFIG/alias.zsh"

# FZF
[[ -f "$ZSH_CONFIG/fzf.zsh" ]] \
    && source "$ZSH_CONFIG/fzf.zsh"

# TMUX
#local main_attached="$(tmux list-sessions -F '#S #{session_attached}' \
#    2>/dev/null \
#    | sed -n 's/^main[[:space:]]//p')"
#if [[ "$main_attached" -le '0' ]] && [[ "$TERM" != 'linux' ]]; then
#    tmux new -A -s main -t main >/dev/null 2>&1
#    exit
#fi

# Alternative prompt
if [[ "$TERM" == "linux" ]] || [[ ! -d "$ZSH_CONFIG" ]]; then
    PROMPT='[%F{167}%B%n%b%f@%M %~]'
    PROMPT+='$(git_prompt_info)'
    PROMPT+=' %(?.%F{108}.%F{167})%B%(!.#.$)%b%f '
    ZSH_THEME_GIT_PROMPT_PREFIX=" [%F{214}%B"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%b%f]"
    ZSH_THEME_GIT_PROMPT_DIRTY="%F{167}%B*%b%f"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
fi

# Autojump
source /etc/profile.d/autojump.zsh

# Empty line
function echo_blank() {
    echo
}
precmd_functions+=echo_blank
preexec_functions+=echo_blank

# Kitty completion
source <(kitty + complete setup zsh)

# Direnv
eval "$(direnv hook zsh)"

# Rbenv
eval "$(rbenv init -)"

# Nvm
export NVM_DIR="$HOME/.config/nvm"
source /usr/share/nvm/init-nvm.sh

# Dotnet
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_ROOT=$HOME/dotnet/2.2.0
export PATH=$PATH:$HOME/dotnet/2.2.0

# Bat theme
export BAT_THEME="ansi-dark"

# kubectl
export KUBECONFIG=$HOME/.kube/config

# Bitwarden
eval "$(bw completion --shell zsh); compdef _bw bw;"

# Default command to run, if any
eval "$RUN"

##########################################################################################

# Debug
#zprof

