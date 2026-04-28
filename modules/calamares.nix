{ lib, pkgs, ... }:

{
  # Calamares branding customization (installer is already imported in the ISO)
  environment.etc."calamares/branding/academix/branding.desc".text = ''
    ---
    componentName: academix

    strings:
      productName: AcademixOS
      shortProductName: AcademixOS
      version: "0.1"
      shortVersion: "0.1"
      versionedName: AcademixOS 0.1
      shortVersionedName: AcademixOS 0.1
      bootloaderEntryName: AcademixOS
      desktopFile: org.kde.plasmashell

    images:
      productLogo: "logo.png"
      productWallpaper: "wallpaper.png"
      productWelcome: "welcome.png"

    colors:
      text: "#000000"
      background: "#ffffff"
      baseText: "#000000"
    '';

  environment.systemPackages = with pkgs; [
    calamares-nixos
    calamares-nixos-extensions
  ];
}