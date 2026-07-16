# Steam Deck Dotfiles

An opinionated KDE Plasma desktop tuned for the Steam Deck's screen size and controller input. Part of [Plasma Deckery](https://github.com/Plasma-Deckery/deckery).

→ **[Full documentation — what each setting does, why it's there, and how to apply it independently](https://plasma-deckery.github.io/deckery/projects/steamdeck-dotfiles/)**

![Desktop layout with activities](docs/assets/dotfiles-activities.png)

## What it does

**Activities and workspaces** — KDE Activities keep different contexts separate (Coding, Gaming, Music, etc.). Each activity has its own virtual desktops, each holding one or two apps in tiling mode that automatically fill the screen. Apps open where they belong — you never have to move or resize windows manually.

**Window tiling** — [Kröhnkite](https://github.com/esjeon/krohnkite) provides dynamic window tiling so windows automatically arrange to fill the screen. [maximized-window-gaps](https://github.com/Plasma-Deckery/maximized-window-gaps) adds configurable gaps around tiled windows.

**Dynamic workspace management** — [Kyanite](https://github.com/Plasma-Deckery/kyanite) ensures there is always one free desktop at the end of the list. Workspaces are created and cleaned up automatically — you never have to manage them manually.

<video src="docs/assets/tiling.mp4" controls autoplay loop muted></video>
<video src="docs/assets/desktopswitch.mp4" controls autoplay loop muted></video>

**Display scaling** — scale 1.1 on the internal display, making UI elements comfortably sized on the 800px screen without blurring from integer scaling.

**Focus follows mouse** — moving the cursor to a window focuses it immediately, no clicking required.

**Steam keyboard focus fix** — a custom KWin script returns focus to the previously active window whenever the Steam on-screen keyboard appears, so keystrokes always land in the right place.

**Flat pointer acceleration** — predictable trackpad cursor speed without the default adaptive curve.

**Power management** — display off after 60s on battery, auto-suspend after 5 minutes, power button suspends.

**Visual effects** — dim inactive windows, hide cursor after 5s of inactivity, subtle translucency on move/resize.

**Voice input** — RNNoise PipeWire filter for noise suppression, works together with [OpenWhispr](https://github.com/OpenWhispr/openwhispr) for hotkey-activated speech-to-text.

## Using these configs

These are personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). They are not designed to be applied wholesale — running `chezmoi apply` would overwrite unrelated personal settings.

Browse the files directly and pick what's relevant to you. The [full documentation](https://plasma-deckery.github.io/deckery/projects/steamdeck-dotfiles/) explains each setting in detail and shows how to apply it independently.
