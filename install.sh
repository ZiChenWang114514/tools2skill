#!/usr/bin/env bash
# install.sh — Add t2s to PATH by symlinking to ~/.local/bin/
# Usage: bash install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
T2S_SRC="$SCRIPT_DIR/t2s"
LOCAL_BIN="$HOME/.local/bin"

if [ ! -f "$T2S_SRC" ]; then
    echo "✗ t2s not found at $T2S_SRC"
    exit 1
fi

mkdir -p "$LOCAL_BIN"
ln -sf "$T2S_SRC" "$LOCAL_BIN/t2s"
chmod +x "$T2S_SRC"

echo "✓ t2s linked: $LOCAL_BIN/t2s → $T2S_SRC"

# Check if ~/.local/bin is in PATH
if echo "$PATH" | grep -q "$LOCAL_BIN"; then
    echo "✓ $LOCAL_BIN is already in PATH"
else
    echo ""
    echo "⚠ Add this to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    echo "Then restart your shell or run:"
    echo "    source ~/.bashrc"
fi

echo ""
echo "Verify: t2s --help"
