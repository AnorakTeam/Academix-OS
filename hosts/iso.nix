{ config, pkgs, modulesPath, ... }:
{
    imports = [
        "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma6.nix"
        "${modulesPath}/installer/cd-dvd/channel.nix"
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # The plasma6 installer module already enables KDE.
    # We can add a few essentials.
    environment.systemPackages = with pkgs; [
        git
        vim
    ];
}