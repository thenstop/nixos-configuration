{ config, pkgs, ... }:

{
  # NVIDIA Driver configuration
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true; # was required for wayland in the past, not sure if it is now
    powerManagement.enable = false; # change if you have issues upon startup from hibernation
    powerManagement.finegrained = false; # use if on Turing or newer [16,20,30,40 series, etc.]
    open = false; # use if on Turing or newer [16,20,30,40 series, etc.]
    nvidiaSettings = true; # change if you dont want the control panel

    package = config.boot.kernelPackages.nvidiaPackages.stable; # change to nvidiaPackages.latest if you use the latest kernel
  };

  # Firefox VA-API configuration
  environment.etc = {
    "environment" = {
      text = ''
        NVD_BACKEND=direct
        MOZ_DISABLE_RDD_SANDBOX=1
        LIBVA_DRIVER_NAME=nvidia
      '';
    };
  };
}
