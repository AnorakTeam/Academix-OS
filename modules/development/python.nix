{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.python.enable = mkEnableOption "Python development tools";

  config = mkIf config.academixos.development.python.enable {
    environment.systemPackages = with pkgs; [
      python312
      python312Packages.pip
      python312Packages.virtualenv
      python312Packages.poetry
      python312Packages.pytest
      python312Packages.jupyter
      python312Packages.numpy
      python312Packages.pandas
      python312Packages.scipy
      python312Packages.matplotlib
      python312Packages.django
      python312Packages.flask
      pypy3
    ];
  };
}