#!/usr/bin/env bash
#
# Install claudius into your PATH (default: ~/.local/bin).
#
# Local clone:   ./install.sh
# One-liner:     curl -fsSL https://raw.githubusercontent.com/inflationcom/claudius/main/install.sh | bash
#
# Override the target:   PREFIX=/usr/local/bin ./install.sh
# Override the source:   CLAUDIUS_REPO=you/claudius  CLAUDIUS_BRANCH=main  ./install.sh
set -euo pipefail

REPO="${CLAUDIUS_REPO:-inflationcom/claudius}"
BRANCH="${CLAUDIUS_BRANCH:-main}"
dest_dir="${PREFIX:-$HOME/.local/bin}"
dest="$dest_dir/claudius"

mkdir -p "$dest_dir"

# Use the script sitting next to this installer if present (local clone),
# otherwise download it (curl | bash).
src_local="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)/claudius"
if [[ -f "$src_local" ]]; then
  cp "$src_local" "$dest"
  echo "installed: $dest  (from local clone)"
else
  url="https://raw.githubusercontent.com/$REPO/$BRANCH/claudius"
  command -v curl >/dev/null 2>&1 || { echo "error: curl is required for the one-liner install" >&2; exit 1; }
  echo "downloading: $url"
  curl -fsSL "$url" -o "$dest"
  echo "installed: $dest"
fi
chmod 0755 "$dest"

# Warn about missing dependencies rather than failing — claude and jq are
# required; curl (usage) and ttyd (serve) are optional.
missing=()
command -v claude >/dev/null 2>&1 || missing+=(claude)
command -v jq     >/dev/null 2>&1 || missing+=(jq)
if ((${#missing[@]})); then
  echo "warning: missing required tools: ${missing[*]}"
  echo "  Claude Code: https://claude.com/code"
  echo "  jq:          brew install jq   /   apt install jq"
fi

# Remind the user if the install dir isn't on their PATH.
case ":$PATH:" in
  *":$dest_dir:"*) ;;
  *) echo "note: $dest_dir is not on your PATH. Add this to your shell profile:"
     echo "      export PATH=\"$dest_dir:\$PATH\"" ;;
esac

echo "done — run: claudius"
