{ config, pkgs, inputs, ... }:

{
  # Import required files
  imports =
    [
      ./hardware-configuration.nix
      ./cloudflared.nix
      ./nix-modules.nix
      ./nix-gaming.nix
      ./plasma.nix
      ./gaming.nix
      ./amd.nix
    ];

  # Setup bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Apply kernel parameters to force x2apic and for realtime performance
  boot.kernelParams = [
    "amd_pstate=active"
    "amd_iommu=on"
    "iommu=pt"
    "noapic"
    "pcie_aspm=off"
    "tsc=reliable"
    "clocksource=tsc"
    "iomem=relaxed"
  ];

  # Use latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Configure network services
  networking.hostName = "basedb850m";
  networking.networkmanager.enable = true;

  # Enable flatpak service
  services.flatpak.enable = true;

  # Configure pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      enable = true;
      quantum = 512;
      rate = 192000;
    };
  };

  # Enable pipewire realtime module
  security.rtkit.enable = true;

  # Setup locale information
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
  };

  # Configure nix package manager
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # Configure user and install packages
  users.users.thenstop = {
    isNormalUser = true;
    description = "Levi Chávez";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      flatpak
      keepassxc

      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans

      wget
      curl
      killall
      pciutils
      git
      gh
    ];
  };

  # Configure autoupgrade
  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = false;
  system.autoUpgrade.channel  = https://nixos.org/channels/nixos-unstable;

  # Configure system state version
  # This lets Nix know the first installed version of NixOS for compat sake
  system.stateVersion = "25.05";
}
