# Highwall2016/homebrew-tap

Homebrew tap for tools by [@Highwall2016](https://github.com/Highwall2016).

## Packages

| Name | Description | Install |
|------|-------------|---------|
| [ccmux](https://github.com/Highwall2016/ccmux) | Control tmux sessions from your phone | `brew install ccmux` |
| [opensoundsource](https://github.com/Highwall2016/open-soundsource) | Per-app audio routing for macOS | `brew install opensoundsource` |

## Usage

```sh
brew tap Highwall2016/tap
brew install ccmux
brew install opensoundsource
```

This installs two binaries:

| Binary | Role |
|--------|------|
| `ccmux` | CLI — spawn, kill, list, and attach to sessions |
| `ccmux-agent` | Background daemon — streams your terminal to the mobile app |

## Get started

```sh
ccmux auth login
```

Opens a browser to sign in with your ccmux account, registers your machine as a device, and starts `ccmux-agent` automatically. Your device will then appear in the ccmux mobile app.

## Auto-start on login (optional)

Run this **after** `ccmux auth login` so credentials exist:

```sh
brew services start ccmux
```

| Command | Effect |
|---------|--------|
| `brew services start ccmux` | Start agent now and on every login |
| `brew services stop ccmux` | Stop the agent and disable auto-start |
| `brew services restart ccmux` | Restart after a credential or config change |

Logs are written to `$(brew --prefix)/var/log/ccmux-agent.log`.

## Update

```sh
brew update && brew upgrade ccmux
```

## Uninstall

```sh
brew services stop ccmux   # stop the agent first
brew uninstall ccmux
brew untap Highwall2016/tap
```

## Packages in this tap

| Formula | Description |
|---------|-------------|
| `ccmux` | CLI + agent for the ccmux mobile app |
