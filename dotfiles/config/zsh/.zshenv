# Variables defined here are not available to services if they use a different
# shebang than zsh. TODO Consider rewriting services using zsh scripts.

export ZIM_HOME=$XDG_DATA_HOME/zim
export ZSH_CACHE_HOME=$XDG_CACHE_HOME/zsh
export HISTFILE=$ZSH_CACHE_HOME/zhistory

# Should remove this once XDG Support is added
export TMUX_CONFIG_HOME=$XDG_CONFIG_HOME/tmux

# If you have host-local configuration, this is where you'd put it
[ -f ~/.zshenv ] && source ~/.zshenv
