{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.office.enable = mkEnableOption "Office and productivity tools";

  config = mkIf config.academixos.development.office.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-fresh
      libreoffice-fresh-unwrapped
      librewolf
      firefox
      thunderbird
      gimp
      inkscape
      blender
      calibre
    ];
  };
}