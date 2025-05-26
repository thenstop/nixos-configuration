{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./gnome.nix
      ./gaming.nix
      ./amd.nix
    ];

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = false;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Network configuration
  networking.hostName = "basedb850m";
  networking.networkmanager.enable = true;

  # Locale properties configuration
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  # Services configuration
  services.flatpak.enable = true;

  services.printing.enable = false;
  services.openssh.enable = false;

  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # My user account
  users.users.thenstop = {
    isNormalUser = true;
    description = "thenstop";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      flatpak
    ];
  };

  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = false;
  system.autoUpgrade.channel  = https://nixos.org/channels/nixos-25.05;

  # Keep default
  system.stateVersion = "25.05";
}
