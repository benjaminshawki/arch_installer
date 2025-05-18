# Arch Linux Installer

This is a personalized Arch Linux installer that automates the installation process with my preferred packages and configurations.

## ⚠️ Warning

This installer will **COMPLETELY ERASE** the selected disk. Make sure you have backups of any important data before proceeding.

## 🚀 Quick Start

1. Boot from an Arch Linux ISO
2. Connect to the internet
3. Run the following commands:

```bash
curl -L https://raw.githubusercontent.com/benjaminshawki/arch_installer/main/install_sys.sh > install_sys.sh
chmod +x install_sys.sh
./install_sys.sh
```

## 📁 Files Overview

- `install_sys.sh` - Main system installer (partitioning, base system)
- `install_chroot.sh` - Configuration inside chroot (bootloader, locale, users)
- `install_user.sh` - User environment setup (AUR helper, dotfiles)
- `install_apps.sh` - Package installation based on categories
- `apps.csv` - Package database with categories and descriptions
- `check_requirements.sh` - Pre-installation system requirements check
- `check_missing_packages.sh` - Find installed packages not in apps.csv

## 🔧 Features

### Modern Package Selection
- **PipeWire** audio stack (replacing PulseAudio)
- **Wayland** with Sway window manager
- **Neovim** with modern plugins
- **Alacritty** GPU-accelerated terminal
- System monitoring tools
- Development environments (Python, Rust, etc.)

### Package Categories
- Essential system tools
- Network utilities
- Development tools
- Window management (Wayland/Sway)
- Audio (PipeWire)
- Terminals and shells
- Programming languages
- Virtualization tools

### Automated Setup
- Disk partitioning (UEFI/BIOS support)
- GRUB bootloader installation
- User creation and sudo configuration
- Timezone and locale setup
- AUR helper (yay) installation
- Dotfiles repository cloning

## 🛠️ Customization

Before running the installer, you may want to:

1. **Update the package list**: Edit `apps.csv` to add/remove packages
2. **Change the GitHub username**: Update references to `benjaminshawki` in the scripts
3. **Modify disk partitioning**: Adjust partition sizes in `install_sys.sh`
4. **Change timezone**: Update the timezone in `install_chroot.sh`

## 📦 Package Groups

The installer allows you to select from these package groups:
- **essential**: Core system utilities
- **network**: Networking tools
- **tools**: Useful command-line utilities
- **tmux**: Terminal multiplexer
- **notifier**: Notification system
- **git**: Version control
- **audio**: PipeWire audio stack
- **wayland**: Wayland compositor and tools
- **zsh**: Z shell and plugins
- **neovim**: Modern text editor
- **alacritty**: Terminal emulator
- **fonts**: Programming fonts
- **browsers**: Web browsers
- **documents**: Document viewers
- **virtualization**: VM and container tools
- **python**: Python development
- **rust**: Rust development
- **database**: Database systems
- **monitoring**: System monitoring

## 🔄 Post-Installation

After installation completes:

1. Reboot into your new system
2. Run the dotfiles installer: `cd ~/dotfiles && ./install.sh`
3. Start Sway from TTY: `sway`
4. Install tmux plugins: Press `prefix + I` in tmux
5. Install Neovim plugins: Run `:Lazy install` in Neovim

## 🤝 Contributing

Feel free to fork this repository and customize it for your own needs. Pull requests with improvements are welcome!

## 📄 License

This project is open source and available under the MIT License.