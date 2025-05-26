{ config, pkgs, ... }:

{
  # Enable AMD Graphics Driver
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
