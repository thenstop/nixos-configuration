{ config, pkgs, ... }:

{
  # Enable and configure X11
  services.xserver.enable = true;

  services.desktopManager.lomiri.enable = true;
  services.displayManager.defaultSession = "lomiri";

  services.xserver.xkb = {
    layout = "us";
  };
}
