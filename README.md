# Steam Deck Dotfiles

An opinionated KDE Plasma desktop tuned for the Steam Deck's screen size and controller input. Part of [Plasma Deckery](https://github.com/Plasma-Deckery/deckery).

→ **[Full documentation — what each setting does, why it's there, and how to apply it independently](https://plasma-deckery.github.io/deckery/projects/steamdeck-dotfiles/)**

![Desktop layout with activities](docs/assets/dotfiles-activities.png)

## What's in here

- **Display scaling** — scale 1.1 on the internal display, comfortable without blurring
- **Window tiling** — [Kröhnkite](https://github.com/esjeon/krohnkite) + [maximized-window-gaps](https://github.com/Plasma-Deckery/maximized-window-gaps)
- **Dynamic workspaces** — [Kyanite](https://github.com/Plasma-Deckery/kyanite) keeps one free desktop available at all times
- **Focus follows mouse** — no clicking required to focus a window
- **Steam keyboard focus fix** — custom KWin script so keystrokes always land in the right app
- **Flat pointer acceleration** — predictable trackpad cursor speed
- **Power management** — display off after 60s, auto-suspend after 5 minutes
- **Visual effects** — dim inactive windows, hide cursor after 5s of inactivity
- **Voice input** — RNNoise PipeWire filter + [OpenWhispr](https://github.com/OpenWhispr/openwhispr)

<video src="docs/assets/tiling.mp4" controls autoplay loop muted></video>
<video src="docs/assets/desktopswitch.mp4" controls autoplay loop muted></video>

## Using these configs

These are personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). They are not designed to be applied wholesale — running `chezmoi apply` would overwrite unrelated personal settings.

Browse the files directly and pick what's relevant to you. The [full documentation](https://plasma-deckery.github.io/deckery/projects/steamdeck-dotfiles/) explains each setting in detail and shows how to apply it with a single command.
