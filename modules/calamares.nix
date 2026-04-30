{ config, pkgs, lib, ... }:

{
  environment.etc."calamares/settings.conf".text = ''
    ---
    modules-search: [ local, /etc/calamares/modules ]
    branding: academix
  '';

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

    images:
      productLogo: "logo.png"

    colors:
      text: "#000000"
      background: "#ffffff"
  '';

  environment.etc."calamares/modules/welcome.conf".text = ''
    ---
    showSupportUrl: false
    showKnownIssuesUrl: false

    welcome:
      message: "Welcome to AcademixOS"
      description: "This installer will guide you through the installation of AcademixOS."
  '';

  environment.etc."calamares/modules/locale.conf".text = ''
    ---
    region: "en_US"
  '';

  environment.systemPackages = with pkgs; [
    calamares-nixos
    calamares-nixos-extensions
  ];
}