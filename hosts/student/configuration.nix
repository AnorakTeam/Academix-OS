{ self, inputs, ... }: {
    flake.nixosModules.studentModules = { pkgs, lib, ... }: {
        imports = [
            ./hardware-configuration.nix
        ];

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        environment.systemPackages = with pkgs; [
            firefox
            nano
        ];
    };   
}
