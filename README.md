# My Personal NixOS Configuration

![Screenshot](screenshot.png)

This is my configuration for NixOS. It works well for me but you can change anything you like for your own needs.

## Contents

### hardware-configuration.nix not included, it should be created upon install instead

- [Configuration.nix](configuration.nix) - `/etc/nixos/configuration.nix` - Main configuration file: handles stuff such as bootloader information and kernel version
- [cloudflared.nix](cloudflared.nix) - `/etc/nixos/cloudflared.nix` - Cloudflare Proxy configuration file: applies my personal NextDNS server
- [AMD.nix](amd.nix) - `/etc/nixos/amd.nix` - AMD Driver Configuration file: enables the amd driver and rocm
- [gaming.nix](gaming.nix) - `/etc/nixos/gaming.nix` - Gaming Configuration file: handles sysctl values and other QOL improvements for a smooth gaming experience
- [plasma.nix](plasma.nix) - `/etc/nixos/plasma.nix` - KDE Plasma 6 Configuration file: removes bloat and makes sddm use wayland
- [flake.nix](flake.nix) - `/etc/nixos/flake.nix` - Flake Configuration file: flakes (Flake) (Flakes) Flake
- [nix-modules.nix](nix-modules.nix) - `/etc/nixos/nix-modules.nix` - Nix-Gaming Configuration file: enables the nix gaming repo for realtime pipewire

## How to install

```sh
git clone https://github.com/thedeveloperever/nix-configuration.git
cd nix-configuration
sudo cp *.nix /etc/nixos/
sudo nixos-rebuild switch --upgrade
```
