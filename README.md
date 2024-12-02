# My Personal NixOS Configuration

[Screenshot](screenshot.png)

This is my configuration for NixOS. It works well for me and you can change anything you like for your own needs. Its free software so that is encouraged! :^)

## Contents

- [Configuration.nix](configuration.nix) - `/etc/nixos/configuration.nix` - Main configuration file: handles stuff such as bootloader information and kernel version
- [Network.nix](network.nix) - `/etc/nixos/network.nix` - Network Configuration file: handles NIC properties for optimial performance (might be placebo but idc)
- [NVIDIA.nix](nvidia.nix) - `/etc/nixos/nvidia.nix` - NVIDIA Driver Configuration file: handles power management and my tweaks for optimal latency
- [Gaming.nix](gaming.nix) - `/etc/nixos/gaming.nix` - Gaming Configuration file: handles sysctl values and other QOL improvements for a smooth gaming experience
- [Gnome.nix](gnome.nix) - `/etc/nixos/gnome.nix` - GNOME Desktop Configuration file: handles my extensions and also removes apps that I personally don't need

## How to install

```sh
git clone https://github.com/thedeveloperever/nix-configuration.git
cd nix-configuration
sudo cp *.nix /etc/nixos/
```
