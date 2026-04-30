{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.java.enable = mkEnableOption "Java development tools";

  config = mkIf config.academixos.development.java.enable {
    environment.systemPackages = with pkgs; [
      jdk21
      jdk17
      maven
      gradle
    ];
  };
}