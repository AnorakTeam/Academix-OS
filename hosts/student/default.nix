{ self, inputs, ... }: {
    flake.nixosConfigurations.student = inputs.nixpkgs.lib.nixosSystem {
        modules = [];
    };
}