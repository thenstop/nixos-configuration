{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./gnome.nix
      ./gaming.nix
      ./amd.nix
      ./zram.nix
    ];

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = false;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "loglevel=4" "mitigations=off" "split_lock_detect=off" "kernel.split_lock_mitigate=0" "intel_pstate=support_acpi_ppc" "vm.vfs_cache_pressure=50" ];

  # Network configuration
  networking.hostName = "basedoptiplex";
  networking.networkmanager.enable = true;

  # Locale properties configuration
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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
    alsa.enable = false;
    alsa.support32Bit = false;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # My user account
  users.users.username = {
    isNormalUser = true;
    description = "username";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      flatpak
      firefox
    ];
  };

  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = false;
  system.autoUpgrade.channel  = https://nixos.org/channels/nixos-24.11;

  # Keep default
  system.stateVersion = "24.11";
}
