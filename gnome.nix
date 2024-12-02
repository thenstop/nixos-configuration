{ config, pkgs, ... }:

{
  # Disable aliases
  nixpkgs.config.allowAliases = false;

  # Enable and configure X11
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Set Keyboard layout - change if you are not from the US
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Setup extensions and theme
  environment.systemPackages = with pkgs; [ 
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.unite
    gnomeExtensions.zen
    gnome-browser-connector
    yaru-theme
  ];

  # Fix for AppIndicator
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Fix Mutter performance - might cause breakage on some devices, highly experimental
  nixpkgs.overlays = [
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab  {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-46";
          hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
        };
      });
    })
  ];

  # Remove unneeded packages - uncomment stuff you want to remove
  environment.gnome.excludePackages = with pkgs; [
    # gnome.gnome-disk-utility
    # gnome.file-roller
    # gnome.gnome-clocks
    # gnome.gnome-calendar
    # gnome.gnome-software
    # gnome.cheese
    # gnome.gnome-shell-extensions
    # gnome.seahorse
    # gnome.gnome-music
    # gnome.geary
    # gnome.gnome-characters
    # gnome.totem
    # gnome.tali
    # gnome.iagno
    # gnome.hitori
    # gnome.atomix
    # gnome.gnome-calculator
    # gnome.yelp
    # gnome.gnome-maps
    # gnome.gnome-weather
    # gnome.gnome-contacts
    # gnome.simple-scan
    # gnome.gnome-logs
    # gnome.eog
    # gnome-usage
    # gnome-connections
    # evince
    # epiphany
    # gnome-photos
    # gnome-tour
    # gnome-text-editor
  ];
}
