{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.editors.enable = mkEnableOption "Development editors";

  config = mkIf config.academixos.development.editors.enable {
    environment.systemPackages = with pkgs; [
      vscode
      code-cursor
      vim
      neovim
      nano
      gedit
      kate
      jetbrains.idea-community
      jetbrains.pycharm-community
    ];
  };
}