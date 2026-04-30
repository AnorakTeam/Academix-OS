{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.databases.enable = mkEnableOption "Database tools";

  config = mkIf config.academixos.development.databases.enable {
    environment.systemPackages = with pkgs; [
      postgresql
      postgresql_15
      sqlite
    ];

    # PostgreSQL service (optional for live environment)
    services.postgresql.enable = false;
  };
}