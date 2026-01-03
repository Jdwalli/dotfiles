# Joshua's Dotfiles
This repository contains most of the relevant dotfiles for my Arch Linux setup and configuration. 

## System Information
**Display Server:** X11  
**Window Manager:** i3  
**Compositor:** Picom  
**Shell:** Zsh  
**Terminal:** Kitty  
**Menu/Launcher:** Rofi  
**Audio:** Pipewire + Wireplumber  
**Network:** NetworkManager  
**Bluetooth:** Bluez  
**Wallpaper:** feh  
**Terminal Decoration:** Starship  

## Installation
### Prerequisites
Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Using GNU Stow

This repository uses GNU Stow for symlink management:
```bash
# Install all configs
stow .
```

### Rofi Configurations
In addition to rofi, I also installed emojis 
https://github.com/Mange/rofi-emoji

### Zsh Plugins
This setup uses  Zsh plugins for enhanced shell experience:

#### zsh-autosuggestions
https://github.com/zsh-users/zsh-autosuggestions

#### zsh-syntax-highlighting
https://github.com/zsh-users/zsh-syntax-highlighting.git 

### Fonts
- `ttf-jetbrains-mono`
- `ttf-hack-nerd`
- `ttf-firacode-nerd`
- `noto-fonts-emoji`
## Notes
- AMD GPU setup with AMDGPU drivers
- TLP configured for laptop power management
- Pipewire for audio (replaces PulseAudio)

