{ config, pkgs, ... }:

{
  # Enable and configure X11
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Setup extensions
  environment.gnome.systemPackages = with pkgs; [ 
    dash-to-dock
    unite
    appindicator
  ];

  # Setup theme
  environment.systemPackages = with pkgs; [ yaru-theme ];

  # Remove unneeded packages
  environment.gnome.excludePackages = with pkgs; [
    snapshot
    baobab
    loupe
    gnome-disk-utility
    file-roller
    gnome-clocks
    gnome-calendar
    gnome-software
    cheese
    seahorse
    gnome-music
    geary
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
    gnome-calculator
    yelp
    gnome-maps
    gnome-weather
    gnome-contacts
    simple-scan
    gnome-logs
    eog
    gnome-usage
    gnome-connections
    evince
    epiphany
    gnome-photos
    gnome-tour
    gnome-text-editor
  ];
}
