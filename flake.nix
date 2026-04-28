{
  description = "AcademixOS - Custom NixOS Distribution";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }@inputs:
    {
      # ISO configurations
      nixosConfigurations = {
        academixos-iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/iso.nix
          ];
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Build the ISO image
        packages = {
          iso = self.nixosConfigurations.academixos-iso.config.system.build.isoImage;
          default = self.nixosConfigurations.academixos-iso.config.system.build.isoImage;
        };
      }
    );
}

