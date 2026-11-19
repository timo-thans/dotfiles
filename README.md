# Dotfiles

Neovim, tmux and Kitty configuration, copied from the original machine. Kitty starts or attaches to the tmux session named `main`.

## Installation

Install Neovim (0.12 or newer), tmux, Kitty, Git and ripgrep using your system package manager. ImageMagick enables image conversion in Neovim; lazygit is optional. A Nerd Font is recommended for icons. Markdown browser preview needs a browser.

Clone this repository, then run:

```sh
./install.sh
```

The script links the configurations and launcher into your home directory. It refuses to overwrite any existing target; move existing configurations aside first. It assumes standard `~/.config` paths. Changes to linked files are changes to this repository.

Open Neovim with internet access to bootstrap lazy.nvim and install plugins; use `:Lazy sync` to retry. The lockfile pins plugin versions. Tree-sitter parsers are installed separately from this repository, so language highlighting, outlines and Markdown rendering may need parsers installed on the new machine. The selected theme is local state; use `:Theme` to choose it.

Kitty starts tmux via the included launcher. Without tmux, the launcher falls back to a login Bash shell. Kitty image rendering may require tmux passthrough and a supported terminal.

## Keeping machines in sync

Commit changes here and push to your own Git remote. On another machine, pull changes in its clone. Run `:Lazy sync` after plugin changes. The existing configuration on the original machine is not linked automatically; back it up and run the installer there if you want changes to stay in sync.
