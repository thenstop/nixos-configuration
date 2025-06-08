{
  # Add nixos-unstable and nix-gaming to flakes
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  # Basic configuration/configure hostname for flakes
  outputs = {self, nixpkgs, ...}@inputs: {
    nixosConfigurations.basedb850m = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        # ...
      ];
    };
  };
}
