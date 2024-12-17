{ config, pkgs, ... }:

{
  # NVIDIA Driver configuration
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Firefox VA-API configuration/OpenGL configuration
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
