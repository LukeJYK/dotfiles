# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). The source state lives in `home-chezmoi/` (set by `.chezmoiroot`).

## Setup on a new machine

Prerequisites: `git`, `chezmoi`, `mise`.

```bash
# 1. Clone the repo
git clone <repo-url> ~/Desktop/dotfiles

# 2. Initialize (prompts for email and whether conda is installed)
chezmoi init --source ~/Desktop/dotfiles

# 3. Preview and apply
chezmoi diff
chezmoi apply

# 4. Install tools managed by mise
mise install
```

> If init fails with `mkdir ~/.config/chezmoi: permission denied`, `~/.config` is owned by root:
> `sudo chown -R "$(whoami)":staff ~/.config`

## Updating

```bash
cd ~/Desktop/dotfiles && git pull
chezmoi apply
```
