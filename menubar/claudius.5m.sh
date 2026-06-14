#!/bin/bash
#
# <xbar.title>claudius usage</xbar.title>
# <xbar.author>claudius</xbar.author>
# <xbar.desc>Per-account Claude usage headroom (5h / 7d) in the menubar.</xbar.desc>
#
# Refreshes every 5 minutes (the ".5m." in the filename). Symlink this into your
# SwiftBar plugin folder:
#   ln -sf ~/claudius/menubar/claudius.5m.sh ~/.config/swiftbar/claudius.5m.sh

# SwiftBar runs plugins with a minimal PATH; make sure the tools are findable.
export PATH="/usr/bin:/bin:/usr/local/bin:/opt/homebrew/bin:$HOME/.local/bin:$PATH"

exec claudius menubar
