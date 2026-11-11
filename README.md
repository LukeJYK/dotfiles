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

## Managed by chezmoi

| Target | Source | Type |
|---|---|---|
| `~/.zshrc` | `home-chezmoi/dot_zshrc.tmpl` | template |
| `~/.wezterm.lua` | `home-chezmoi/dot_wezterm.lua.tmpl` | template |
| `~/.condarc` | `home-chezmoi/dot_condarc` | file |
| `~/.config/starship.toml` | `home-chezmoi/dot_config/starship.toml` | file |
| `~/.config/mise/config.toml` | `home-chezmoi/dot_config/mise/config.toml` | file |
| `~/.gitconfig` | `git/.gitconfig` | symlink |
| `~/.vimrc` | `vim/.vimrc` | symlink |
| `~/.config/sketchybar` | `sketchybar/` | symlink |

Symlinks point into this repo, so edits there take effect immediately without `chezmoi apply`.

Not managed (link manually if needed): `aerospace/`, `cluster/`.

## Installed by mise

See `home-chezmoi/dot_config/mise/config.toml`. All tools track `latest` except neovim (`nightly`).

- **Runtimes / package managers:** uv, node, bun, pnpm
- **Editor:** neovim
- **Python:** ruff, pyright
- **JS / TS / Web:** biome, typescript, typescript-language-server, vscode-langservers-extracted
- **Lua:** stylua, lua-language-server
- **Shell:** shellcheck
- **Markdown / YAML:** prettier, markdownlint-cli2, markdown-toc
- **CLI:** eza, fzf, gh, zoxide, awscli, pi, usage

npm packages are installed through bun (`npm.package_manager = "bun"`).

## Updating

```bash
cd ~/Desktop/dotfiles && git pull
chezmoi apply
```
