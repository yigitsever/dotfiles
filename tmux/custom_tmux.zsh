# tmux plugin override
# CONFIGURATION VARIABLES
# Automatically start tmux
: ${ZSH_TMUX_AUTOSTART:=true}

# Only autostart once. If set to false, tmux will attempt to
# autostart every time your zsh configs are reloaded.
: ${ZSH_TMUX_AUTOSTART_ONCE:=false}

# Automatically connect to a previous session if it exists
: ${ZSH_TMUX_AUTOCONNECT:=false}
