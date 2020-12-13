# -----------------
# Zsh configuration
# -----------------

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

eval "$(starship init zsh)"
