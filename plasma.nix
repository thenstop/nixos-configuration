{ config, pkgs, ... }:
{
  # Setup SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Exclude unwanted packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    gwenview
    okular
    kate
    khelpcenter
    elisa
    baloo-widgets
    krdp
    xwaylandvideobridge
  ];
}
