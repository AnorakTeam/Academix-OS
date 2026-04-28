{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.kde.enable = mkEnableOption "KDE Plasma 6 desktop";

  config = mkIf config.academixos.kde.enable {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kate
      kdePackages.konsole
      kdePackages.dolphin
      kdePackages.okular
      kdePackages.gwenview
      kdePackages.ark
      kdePackages.kcalc
      kdePackages.kwrite
      kdePackages.kfind
      kdePackages.plasma-browser-integration
      kdePackages.kde-gtk-config
      kdePackages.kdeplasma-addons
    ];
  };
}