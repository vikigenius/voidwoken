# Workaround till we have XDG support in 3.2
alias tmux='tmux -f $TMUX_CONFIG_HOME/tmux.conf'

# dotdrop
alias dotdropu='dotdrop -c ~/.local/lib/voidwoken/config_user.yaml'
alias dotdropr='dotdrop -c ~/.local/lib/voidwoken/config_root.yaml'

# XDG modifications
alias mbsync='mbsync -c $XDG_CONFIG_HOME/isync/mbsyncrc'
