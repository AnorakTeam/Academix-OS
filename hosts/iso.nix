{ config, pkgs, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    ../modules
  ];

  # Nix flakes support
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # For faster builds
    max-jobs = "auto";
    cores = 0;
  };

  # Allow unfree packages (for VSCode, etc.)
  nixpkgs.config.allowUnfree = true;

  # ISO image customization
  isoImage.edition = "academix";
  isoImage.volumeID = "AcademixOS";
  
  # Desktop environment
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Install user
  users.users.liveuser = {
    isNormalUser = true;
    initialPassword = "liveuser";
    extraGroups = [ "wheel" ];
  };

  # Development tools will be added via modules
  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    nano
    fastfetch
    curl
    wget
    gparted
    gnome-disk-utility
  ];

  # Enable all development tools
  academixos = {
    kde.enable = true;
    development = {
      enable = true;
      python.enable = true;
      java.enable = true;
      cpp.enable = true;
      databases.enable = true;
      docker.enable = true;
      editors.enable = true;
      office.enable = true;
    };
  };

  system.stateVersion = "25.11";
}