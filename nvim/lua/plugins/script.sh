#!/usr/bin/env bash
# Static banner output (no animation loop to prevent ghosting)
if command -v lolcat >/dev/null 2>&1; then
    lolcat "$1"
else
    cat "$1"
fi
