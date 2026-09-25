# dotfiles

My personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a Stow package whose contents mirror the layout of `$HOME`. Running `stow <package>` symlinks those files from `$HOME` back into this repository.

## Packages

| Package | Files | Notes |
| --- | --- | --- |
| `git` | `.gitmessage` | commit message template |
| `tmux` | `.tmux.conf` | tmux configuration |
| `tig` | `.tigrc` | tig configuration |
| `zsh` | `.zshrc`, `.zshrc.mac`, `.zshrc.linux` | zsh configuration |
| `starship` | `.config/starship.toml` | prompt (Starship) |
| `ghostty` | `.config/ghostty/config.ghostty` | Ghostty terminal |
| `wezterm` | `.wezterm.lua` | WezTerm terminal |
| `vim` | `.vimrc`, `.ideavimrc` | Vim + JetBrains IDEAVim |
| `posh` | `Microsoft.PowerShell_profile.ps1`, `.mytheme.omp.json` | PowerShell (Windows only) |

## Setup

### macOS / Linux

```sh
git clone git@github.com:lln133208/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs `stow` (and `starship` / `ghostty` if missing), then links the packages.

To link a single package manually:

```sh
cd ~/.dotfiles
stow -v --target="$HOME" <package>
```

### Windows

Use `bootstrap.ps1` (PowerShell). Symlinks can also be created manually:

```powershell
New-Item -ItemType SymbolicLink -Path <target> -Name <name> -Value <source>
```

## zsh

oh-my-zsh is installed and updated by oh-my-zsh itself at `~/.oh-my-zsh`; it is **not** vendored in this repository. Only the personal part is kept here:

- `.zshrc` — entry point: sets `ZSH`, Homebrew mirrors, and sources the platform-specific file.
- `.zshrc.mac` — macOS customization (plugins, PATH, pyenv, Starship, aliases).
- `.zshrc.linux` — Linux customization.

## Notes

- `posh` and `.ideavimrc` are Windows-only.
- macOS paths assume Apple Silicon (Homebrew at `/opt/homebrew`).
- Link any additional package (e.g. `wezterm`) with `stow <package>`.
