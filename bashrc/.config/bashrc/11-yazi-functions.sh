yazi() {
    if [ -n "$YAZI_LEVEL" ]; then
        echo "🚫 You are already in a Yazi subshell (Level $YAZI_LEVEL)."
        echo "   Type 'exit' (or press Ctrl+D) to return to Yazi."
        return 1
    fi
    # If not in a subshell, run the actual yazi command
    command yazi "$@"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
