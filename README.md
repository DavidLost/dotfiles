## My dotfiles :)

**Note:** configs are expected under `~/.config` (zsh, fish, nvim, scripts).

### Prerequisites (Arch/CachyOS)

Install required packages:

```sh
sudo pacman -S --needed git stow zsh fish neovim eza bat fastfetch wget curl \
  zsh-autosuggestions zsh-syntax-highlighting wireguard-tools aircrack-ng \
  optimus-manager expac
```

Install oh-my-zsh:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.config/oh-my-zsh
```

Install powerlevel10k:

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ~/.config/oh-my-zsh/custom/themes/powerlevel10k
```

Optional: install oh-my-fish

```sh
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

### Installation

1. Clone this repo:
   ```sh
   git clone https://github.com/H3xaChad/dotfiles.git ~/dotfiles
   ```

2. Symlink configs with stow:
   ```sh
   cd ~/dotfiles && stow --target="$HOME" .
   ```

3. Ensure zsh plugin symlinks exist (needed for this setup):
   ```sh
   mkdir -p $ZSH_CUSTOM/plugins/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
   ln -sf /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
   ln -sf /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
   ```

4. Reload shell and open nvim once:
   ```sh
   exec zsh
   nvim
   ```

Now u should be good 2 go. If not, blame cosmic rays.
