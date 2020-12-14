# Variables defined here are not available to services if they use a different
# shebang than zsh. TODO Consider rewriting services using zsh scripts.

# If not using a DM (eg: login tty) then etc/profile hasn't been sourced
# And none of the XDG DIRS are available yet so don't use them here unless you
# restruecture.

# If you have host-local configuration, this is where you'd put it
[ -f ~/.zshenv ] && source ~/.zshenv
