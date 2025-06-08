{ config, pkgs, ... }:

{
  # Enable AMD Graphics Driver
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Allow rocm to run from anywhere
  systemd.tmpfiles.rules = 
  let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  # install rocm
  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
}
