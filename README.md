# My Personal NixOS Configuration

![Screenshot](screenshot.png)

This is my configuration for NixOS. It works well for me but you can change anything you like for your own needs.

## Contents

### hardware-configuration.nix not included, it should be created upon install (instead of using mine ofc)

- [Configuration.nix](configuration.nix) - `/etc/nixos/configuration.nix` - Main configuration file: handles stuff such as bootloader information and kernel version
- [ZRAM.nix](zram.nix) - `/etc/nixos/zram.nix` - zram configuration file: handles ssd trimming and creates 2 zstd-compressed swap devices that equal the amount of system memory
- [AMD.nix](amd.nix) - `/etc/nixos/amd.nix` - NVIDIA Driver Configuration file: handles power management and my tweaks for optimal latency
- [Gaming.nix](gaming.nix) - `/etc/nixos/gaming.nix` - Gaming Configuration file: handles sysctl values and other QOL improvements for a smooth gaming experience
- [Lomiri.nix](lomiri.nix) - `/etc/nixos/lomiri.nix` - I like experimental stuff what can I say

## How to install

```sh
git clone https://github.com/thedeveloperever/nix-configuration.git
cd nix-configuration
sudo cp *.nix /etc/nixos/
```
