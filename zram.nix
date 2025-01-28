{ config, pkgs, ... }:

{
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  zramSwap = {
      enable = true;
      priority = 100;
      memoryPercent = 50;
      algorithm = "zstd";
      swapDevices = 2;
  };

}
