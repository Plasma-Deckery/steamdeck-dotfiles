# Steam Deck Dotfiles

An opinionated KDE Plasma desktop setup tuned for the Steam Deck's screen size and input methods. Part of [Plasma Deckery](https://github.com/Plasma-Deckery/deckery).

The goal is a desktop that works well with a controller and no keyboard — clean, fast to navigate, and organised so you always know where things are.

![Desktop layout with activities](docs/assets/dotfiles-activities.png)

## What it does

**Activities and workspaces** — KDE Activities keep different contexts separate (Coding, Gaming, Music, etc.). Each activity has its own virtual desktops, each holding one or two apps in tiling mode that automatically fill the screen.

<video src="docs/assets/tiling.mp4" controls autoplay loop muted></video>

**Dynamic workspace management** — a KWin script ([Kyanite](https://github.com/Plasma-Deckery/kyanite)) ensures there is always one free desktop at the end of the list. Workspaces are created and cleaned up automatically.

<video src="docs/assets/desktopswitch.mp4" controls autoplay loop muted></video>

**Focus follows mouse** — moving the cursor to a window focuses it immediately, no clicking required.

**Voice input** — RNNoise PipeWire filter for noise suppression, works together with [OpenWhispr](https://github.com/OpenWhispr/openwhispr) for hotkey-activated speech-to-text.

→ [Full documentation](https://plasma-deckery.github.io/deckery/projects/steamdeck-dotfiles/)

## Installation

These dotfiles are managed with [chezmoi](https://www.chezmoi.io/):

```bash
chezmoi init https://github.com/Plasma-Deckery/steamdeck-dotfiles
chezmoi apply
brew bundle
xargs flatpak install < flatpaks.txt
```

See the [Chezmoi & Tracking](https://plasma-deckery.github.io/deckery/projects/steamdeck-dotfiles/chezmoi/) page for the full details.
