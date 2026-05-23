# Steam Deck Dotfiles Guide

This repository contains the tracked configuration for the Steam Deck setup.

## Goals

- Reproduce the current system state after reinstall.
- Keep all trackable configuration under version control.
- Document every non-trackable or partially trackable step.

## Current Scope

Tracked with chezmoi + git:

- Shell: bashrc, git config, other safe shell config files
- KDE: core Plasma and KWin user config files
- VS Code: extension list and selected editor config files
- Package manifests: Brewfile

Not automatically tracked:

- Flatpak installs from Flathub
- Actions done via Bazzite portal
- Decky Loader install steps
- Secrets and credentials

## Base Requirements

Install or ensure availability of:

- git
- chezmoi
- Homebrew
- gh (GitHub CLI)

Optional later:

- devbox
- nix and home-manager

## Repository Bootstrap on a Fresh System

1. Install chezmoi.
2. Initialize from this repo.
3. Apply dotfiles.
4. Install brew packages from Brewfile.
5. Restore Flatpaks from flatpak list file.
6. Perform documented non-trackable steps manually.

## Daily Workflow

1. Make system/config change.
2. Add changed config file with chezmoi add if needed.
3. Export package manifests when package state changed.
4. Update documentation for non-trackable actions.
5. Commit and push.

## Flatpak Policy

Flatpaks are not auto-committed.
After each Flatpak change, regenerate the manifest file and commit it.

Example command:

flatpak list --app --columns=application | sort > flatpaks.txt

## Non-Trackable Changes Log

If you do anything via Bazzite portal or installers that do not map cleanly to config files, document it under this section.

Template:

- Date:
- Action:
- Tool or portal used:
- Why needed:
- How to reproduce on fresh system:
- Verification:

## Security Rules

Never commit:

- .env files
- API keys or tokens
- credentials files
- private keys

If a secret is accidentally committed:

1. rotate secret immediately
2. remove from repository history
3. force-push only after validation

## Next Planned Steps

1. Add flatpaks.txt to tracked files and keep it updated.
2. Add a reproducible Decky Loader section once method is fixed.
3. Decide on devbox install timing and track first install commit.
