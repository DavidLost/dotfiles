## My dotfiles :)

**Note:** These dotfiles use custom locations to keep the home directory clean. oh-my-zsh, `.zshrc`, and other configs are moved to `~/.config/` instead of cluttering the home directory.

### Prerequisites
- stow
- neovim
- zsh
- fish
- oh-my-zsh
  ```sh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```
- oh-my-fish
  ```sh
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
  ```

### Installation
1. Clone this repo into your home directory:
   ```sh
   git clone https://github.com/H3xaChad/dotfiles.git
   ```

2. Navigate to the dotfiles directory and use stow to create symlinks for .config folders:
   ```sh
   cd dotfiles && stow .
   ```

3. **Arch Linux only (if you wanna use the aur packages)** Install and create symlinks for zsh plugins:
   
   Install the plugins:
   ```sh
   sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting
   ```
   
   Create symlinks:
   ```sh
   mkdir -p $ZSH_CUSTOM/plugins/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
   ln -s /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
   ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
   ```

Now u should be good 2 go :)
