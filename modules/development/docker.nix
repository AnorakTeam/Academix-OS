{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.docker.enable = mkEnableOption "Docker and container tools";

  config = mkIf config.academixos.development.docker.enable {
    environment.systemPackages = with pkgs; [
      docker
      docker-compose
      podman
      podman-compose
    ];

    # Don't enable Docker daemon in live ISO to save resources
    virtualisation.docker.enable = false;
    virtualisation.podman.enable = false;
  };
}