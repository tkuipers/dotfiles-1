# If not running interactively then do nothing
[[ $- != *i* ]] && return

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

# extends regexes
shopt -s extglob


[ -f "$HOME/.aliases" ] && . $HOME/.aliases
[ -f "$HOME/.local_aliases" ] && . $HOME/.local_aliases

# Add a bunch of directories to my PATH if they exist
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/local/bin" ] && PATH="$HOME/local/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/node_modules" ] && PATH="$HOME/node_modules/.bin:$PATH"
[ -d "$HOME/Downloads/gradle-2.4-bin/bin" ] && PATH="$HOME/Downloads/gradle-2.4-bin/bin:$PATH"
[ -d "$HOME/eclipse" ] && PATH="$HOME/eclipse:$PATH"
[ -d "$HOME/usr/bin" ] && PATH="$HOME/usr/bin:$PATH"

# Hide commands prefixed with spaces
export HISTCONTROL="ignorespace"

# Set some default programs
export EDITOR="vim"
export BROWSER=/usr/bin/qutebrowser
# Change the default man pager to vim
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# Only set my PS1 if I'm in an interactive session
if [[ $- == *i* ]]; then
	###############
	#  START PS1  #
	###############

	PS1="\u"
	PS1+="\[$(tput setaf 2)\]@"
	PS1+="\[$(tput sgr0)\]\H"
	PS1+="\[$(tput setaf 2)\]\w"
	PS1+="\[$(tput sgr0)\]"
	PS1+=' $(parse_git_branch)\n'
	PS1+="\[$(tput setaf 3)\]\$"
	PS1+="\[$(tput sgr0)\] "

	export PS1
	#############
	#  END PS1  #
	#############
fi

# This is the git prompt method from github.com/git/git/
# source ~/.dotfiles/git-prompt.sh

# Environment variables for golang
export GOROOT="$HOME/Programming/lang/go"
PATH="$PATH:$GOROOT/bin"
export GOPATH="$HOME/Programming/go"
PATH="$PATH:$GOPATH/bin"

## Add Tomcat servlet api to CLASSPATH
[ -d /usr/share/java ] && CLASSPATH="/usr/share/java/tomcat-servlet-api-3.0.jar:$CLASSPATH"

## Use alternatively installed java8
[ -d /opt/jdk/jdk1.8.0_65/bin/ ] && PATH="/opt/jdk/jdk1.8.0_65/bin/:$PATH"

## termite color setup
[ -f ~/.dircolors ] && eval $(dircolors ~/.dircolors)

## bspwm
# Add my bspwm directories to my PATH
[ -d "$HOME/.config/bspwm/panel" ] && PATH="$HOME/.config/bspwm/panel:$PATH"
[ -d "$HOME/.config/bspwm/scripts" ] && PATH="$HOME/.config/bspwm/panel/scripts:$PATH"

## ranger
# load custom config file, not the default
export RANGER_LOAD_DEFAULT_RC=false

## fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

## command correction
if command -v thefuck > /dev/null 2>&1; then
	eval "$(thefuck --alias f > /dev/null 2>&1)"
fi

## Neovim
# Fix colors (default $TERM is xterm)
# [[ $(hostname) =~ ^[L119|N221].* ]] && export TERM=xterm-256color
[ -n "$SSH_CONNECTION" ] && export TERM=xterm-256color
# Use locally installed neovim if exists
[ -d "$HOME/neovim/bin" ] && PATH="$HOME/neovim/bin:$PATH"

# Add local install of jdk 8 to my PATH
[ -d ~/bin/jdk1.8.0_60/bin ] && PATH="$HOME/bin/jdk1.8.0_60/bin:$PATH"

# Make sure default config folder is set
[ -d ~/.config ] && export XDG_CONFIG_HOME="$HOME/.config/"

# Ruby gem binaries
[ -d ~/.gem/ruby/2.2.0/bin ] && PATH="$PATH:$HOME/.gem/ruby/2.2.0/bin"
[ -d ~/.gem/ruby/1.9.1/bin ] && PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"

# Sort-of-not-really working fix for weird javax.swing issues in bspwm
export _JAVA_AWT_WM_NONREPARENTING=1

export PATH
export CLASSPATH

# Source a local bashrc to add or overwrite things
[ -f "$HOME/.local_bashrc" ] && . $HOME/.local_bashrc

export NVM_DIR="/home/erik/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
