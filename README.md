# claudius

A launcher and session manager for [Claude Code](https://claude.com/code).

Switch between your Claude accounts, browse and resume sessions per project, and
keep an eye on your usage limits — all from one keyboard-driven terminal UI.
Claude Code runs unchanged underneath; claudius just helps you find the right
chat and decide which account to run it with.

> *many crowns, one conversation*

![demo](docs/demo.gif)
<!-- record a short demo and drop it at docs/demo.gif -->

## Features

- **Multi-account** — switch the active Claude account with one keypress. Backup-account tokens live in your OS secret store (macOS Keychain, libsecret, or a `0600` file).
- **Per-project sessions** — the recent chats for the folder you're in, labelled with your actual first message and a relative time.
- **Resume anywhere** — open any chat from any project; claudius `cd`s into the right folder for you.
- **Usage at a glance** — session (5h), weekly (7d) and subscription-renewal countdowns, per account.
- **Menubar widget** — `claudius menubar` feeds a `⚡<headroom>%` badge with per-account detail to [SwiftBar](https://github.com/swiftbar/SwiftBar) (macOS) or [Argos](https://github.com/p-e-w/argos)/[xbar](https://github.com/matryer/xbar) (Linux).
- **Organize** — archive, delete (recoverable), pin and rename chats, plus fuzzy search.
- **Phone access** — `claudius serve` exposes the UI as a web terminal over your private network.

## Requirements

- [Claude Code](https://claude.com/code) (`claude`)
- `jq`
- Optional: `curl` (usage display), `ttyd` (`claudius serve`)
- Optional: SwiftBar (macOS) or Argos/xbar (Linux) for the menubar widget
- macOS or Linux. On Windows, use WSL.

## Install

**One-liner** (macOS / Linux):

```sh
curl -fsSL https://raw.githubusercontent.com/inflationcom/claudius/main/install.sh | bash
```

**Homebrew** (macOS / Linux):

```sh
brew install inflationcom/tap/claudius
```

**From a clone:**

```sh
git clone https://github.com/inflationcom/claudius
cd claudius
./install.sh
```

All three drop the single `claudius` script into `~/.local/bin` (override with
`PREFIX=…`). It's one self-contained file — you can also just put it anywhere on
your `PATH` and `chmod +x` it.

## Usage

Run `claudius` in any project folder. Arrow keys move through your chats, Enter
opens one, and the command bar at the bottom lists the single-key actions:

| key       | action                                   |
|-----------|------------------------------------------|
| `↵`       | open the selected chat                   |
| `n`       | new chat                                 |
| `/`       | search this folder                       |
| `s`       | accounts — usage per account + switch    |
| `j`       | jump to another project                  |
| `a d r p` | archive / delete / rename / pin selected |
| `m`       | more — all folders, archived, add account|
| `q`       | quit                                     |

### Adding a backup account

Open **`m` → Add account**. It runs `claude setup-token`; sign in as that account
in the browser and paste the token back. claudius stores it in your OS secret
store and never writes it to a dotfile in plain text (unless no secret store is
available, in which case it falls back to a `0600` file).

### Switching accounts mid-chat

Hit a limit? Quit Claude (`Ctrl-C` or `/quit`). claudius offers to switch accounts
and resume the *same* chat under the new one — the conversation continues.

### Continue on your phone

On the machine that holds your sessions (with `ttyd` and a private network such
as [Tailscale](https://tailscale.com)):

```sh
claudius serve
```

Open the printed URL in your phone's browser, on the same network. The host
machine must be awake. See the warning the command prints — a web terminal is
full shell access, so keep it on a trusted network.

### Usage in your menubar

A `⚡<headroom>%` badge plus per-account 5h/7d detail, in your menubar. One command:

```sh
claudius menubar install
```

That writes a plugin to `~/.config/swiftbar/`. Then:

- **macOS:** `brew install --cask swiftbar`, launch it, point its plugin folder
  at `~/.config/swiftbar`.
- **Linux:** install [Argos](https://github.com/p-e-w/argos) (GNOME) or
  [xbar](https://github.com/matryer/xbar) and pass its plugin dir:
  `claudius menubar install ~/.config/argos`.

(Under the hood it just runs `claudius menubar`, which prints SwiftBar/xbar format.)

## Configuration

State lives in `~/.config/claudius/`. Environment variables:

- `CLAUDIUS_NOANIM=1` — disable the intro animation
- `CLAUDIUS_SERVE_PORT` — port for `serve` (default `7681`)
- `CLAUDE_CONFIG_DIR` — respected for locating Claude Code's sessions

## How accounts work

Claude Code stores its login in the OS keychain (or `~/.claude/.credentials.json`).
claudius switches accounts by exporting `CLAUDE_CODE_OAUTH_TOKEN`, which Claude
Code prefers over its stored login. Your chats live in `~/.claude/projects/` and
are independent of the account, so the same chat resumes under any of them.

## Notes & disclaimers

- **Usage figures** come from Claude's account API. These endpoints are not part
  of a public, documented API and may change without notice. If they do, the
  launcher keeps working and the usage panel just shows *unavailable* — nothing
  else depends on them.
- **Multiple accounts**: claudius switches between accounts *you own*. Whether
  running multiple subscriptions fits Anthropic's Terms of Service is your call —
  claudius doesn't bypass any limits, it only chooses which credentials Claude
  Code uses.

## License

[MIT](LICENSE)
