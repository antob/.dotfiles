###########
#  LOCAL  #
###########

[[ -f ~/.local.profile ]] && \
    source ~/.local.profile


###################
#  ENV VARIABLES  #
###################

# lua
#export PATH="$HOME/.luarocks/bin:$PATH"

# python
#export PYTHONSTARTUP="$HOME/.pythonrc.py"

# user scripts
export PATH="$HOME/.local/bin:$PATH"

# terminal emulator
export TERMINAL='kitty'

# editor
export VISUAL='vim'
export EDITOR='vim'

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# makeflags
export MAKEFLAGS="-j$(nproc)"

# man / less colors
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
#export LESS_TERMCAP_so=$'\e[30;48;5;208m'
export LESS_TERMCAP_so=$'\e[38;5;208;48;5;239m'
export LESS_TERMCAP_se=$'\e[39;49m'
export LESS_TERMCAP_us=$'\e[4;96m'
export LESS_TERMCAP_ue=$'\e[0m'
export MANLESS=" [1m\$MAN_PN[0m${LESS_TERMCAP_so} ?ltline %lt?L/%L.:byte %bB?s/%s..?pB %pB\%. "
export MANROFFOPT='-c'
export LESS='-iMRSj.3'
export SYSTEMD_LESS="$LESS"

# # man / less colors (using tput)
# export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
# export LESS_TERMCAP_md=$(tput bold; tput setaf 4)
# export LESS_TERMCAP_me=$(tput sgr0)
# export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 11)
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# export LESS_TERMCAP_us=$(tput smul; tput setaf 14)
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export MANROFFOPT='-c'
# export LESS='-iMRj.3'

# # man width
# MAN_MAX_WIDTH='105'
# export MANWIDTH=$(tput cols)
# [ "$MANWIDTH" -gt "$MAN_MAX_WIDTH" ] && export MANWIDTH=$MAN_MAX_WIDTH

# Configure pinentry to use the correct TTY
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null

# qt theme
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE=Breeze

# GTK 3 theme
#export GTK_THEME=Adwaita:dark
#export GDK_SCALE=2
#export GDK_DPI_SCALE=0.5

# firefox scroling
export MOZ_USE_XINPUT2=1

