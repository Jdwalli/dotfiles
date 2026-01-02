#!/bin/sh
# ~/.zprofile
# Environment variables set on login (before .zshrc)
# Shell-specific settings go in ~/.zshrc

# Default Programs:
export EDITOR="nano"
export VISUAL="nano"
export BROWSER="firefox"
export TERMINAL="kitty"


# XDG Base Directory Specification:
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# History Files:
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"

# Other files and vars
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
