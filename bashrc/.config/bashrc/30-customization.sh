# -----------------------------------------------------
# CUSTOMIZATION
# -----------------------------------------------------
POSH=agnoster

# -----------------------------------------------------
# Prompt
# -----------------------------------------------------
# eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/zen.toml)"
eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/EDM115-newline.omp.json)"

# FZF
eval $(fzf --zsh)

# Fuck
eval $(thefuck --alias)

# Zoxide
eval "$(zoxide init bash)"
alias cd="z"

# -----------------------------------------------------
# Pywal
# -----------------------------------------------------
# cat ~/.cache/wal/sequences
