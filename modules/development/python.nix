{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.python.enable = mkEnableOption "Python development tools";

  config = mkIf config.academixos.development.python.enable {
    environment.systemPackages = with pkgs; [
      python314
      python314Packages.pip
      python314Packages.virtualenv
      poetry
      python314Packages.pytest
      python314Packages.jupyter
      python314Packages.numpy
      python314Packages.pandas
      python314Packages.scipy
      python314Packages.matplotlib
      python314Packages.django
      python314Packages.flask
      pypy3
    ];
  };
}