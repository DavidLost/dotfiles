## dotfiles

Minimal setup for zsh, fish, Neovim, and utility scripts.

## Packages

Arch/CachyOS:

```bash
sudo pacman -S --needed git stow zsh fish neovim eza bat fastfetch wget curl \
   zsh-autosuggestions zsh-syntax-highlighting
```

Debian/Ubuntu:

```bash
sudo apt update
sudo apt install -y git stow zsh fish neovim eza bat wget curl
```

If your distro has no `eza` package, install `exa` and replace the related aliases.

Optional (used by some aliases):

```bash
sudo pacman -S --needed wireguard-tools aircrack-ng optimus-manager expac
```

## Install after clone

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
stow --target="$HOME" .
```

Install Oh My Zsh and place it where this repo expects it:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.config/oh-my-zsh
```

Install Oh My Fish (optional, for fish framework features):

```bash
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

Install Powerlevel10k:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
   ~/.config/oh-my-zsh/custom/themes/powerlevel10k
```

Finalize:

```bash
exec zsh
nvim
```

If anything breaks, blame cosmic rays first.
