{inputs, ...}: {
  # Enable Pipewire Low Latency module
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
}
