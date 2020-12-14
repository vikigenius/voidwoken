# -----------------
# Zsh configuration
# -----------------

# ----------------------
# Initialize environment
# ----------------------
#
export ZIM_HOME=$XDG_DATA_HOME/zim
export ZSH_CACHE_HOME=$XDG_CACHE_HOME/zsh
export HISTFILE=$ZSH_CACHE_HOME/zhistory

# Should remove this once XDG Support is added
export TMUX_CONFIG_HOME=$XDG_CONFIG_HOME/tmux


source $ZDOTDIR/config.zsh

# ------------------
# Initialize modules
# ------------------

if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

source $ZDOTDIR/keybinds.zsh
source $ZDOTDIR/aliases.zsh


fpath=( $ZDOTDIR/autoloads "${fpath[@]}" )

# My custom autoloads
autoload -Uz xevkey

# If you have host-local configuration, this is where you'd put it
[ -f ~/.zshrc ] && source ~/.zshrc

# Custom starship prompt only in non pseudo terminal slaves

case $(tty) in /dev/pts/[0-9]*)
    eval "$(starship init zsh)" ;;
esac
