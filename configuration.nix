{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./network.nix
      ./gnome.nix
      ./gaming.nix
      ./nvidia.nix
    ];

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = false;
  boot.kernelParams = [ "loglevel=4" ]; # put your preferred kernel parameters here 
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Network configuration
  networking.hostName = "nixos-computer";
  networking.networkmanager.enable = true;

  # Locale properties configuration
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Services configuration
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # My user account
  users.users.username = { # change username
    isNormalUser = true;
    description = "username"; # change username
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      flatpak
    ];
  };

  # Installed packages 
  environment.systemPackages = with pkgs; [
    firefox
    nvidia-vaapi-driver
  ];

  # Keep as the version you installed (doesn't change the system version as its rolling release)
  system.stateVersion = "24.11";
}
