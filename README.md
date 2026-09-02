## My dotfiles :)

Small setup for zsh + Neovim + scripts.

## Install (Arch/CachyOS)

```bash
sudo pacman -S --needed git stow zsh neovim eza bat fastfetch wget curl \
	zsh-autosuggestions zsh-syntax-highlighting
```

Optional (used by some aliases):

```bash
sudo pacman -S --needed wireguard-tools aircrack-ng optimus-manager
```

## Install (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install -y git stow zsh neovim eza bat fastfetch wget curl
```

If `bat` is installed as `batcat`, add:

```bash
alias bat='batcat'
```

## After clone (make it work)

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
stow --target="$HOME" .
```

Install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Then place it at `.config/oh-my-zsh` (as expected by this setup):

```bash
mv ~/.oh-my-zsh ~/.config/oh-my-zsh
```

Install Powerlevel10k theme:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
	~/.config/oh-my-zsh/custom/themes/powerlevel10k
```

Open a new shell:

```bash
exec zsh
```

## Neovim

- Base: NvChad v2.5
- First run: `nvim`
- Update plugins later with `:Lazy sync`

If something explodes, blame cosmic rays first.
