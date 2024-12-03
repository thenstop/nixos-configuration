{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./gnome.nix
      ./gaming.nix
      ./nvidia.nix
      ./zram.nix
    ];

  # Bootloader configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = false;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "loglevel=4" "mitigations=off" "split_lock_detect=off" "kernel.split_lock_mitigate=0" "intel_pstate=support_acpi_ppc" "vm.vfs_cache_pressure=1" ];

  # Network configuration
  networking.hostName = "basedoptiplex";
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

  services.printing.enable = false;
  services.openssh.enable = false;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

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
      nvidia-vaapi-driver
    ];
  };

  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = true;
  system.autoUpgrade.channel  = https://nixos.org/channels/nixos-24.11;

  # Keep default
  system.stateVersion = "24.05";
}
