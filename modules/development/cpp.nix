{ config, lib, pkgs, ... }:

with lib;

{
  options.academixos.development.cpp.enable = mkEnableOption "C++ development tools";

  config = mkIf config.academixos.development.cpp.enable {
    environment.systemPackages = with pkgs; [
      gcc
      clang
      cmake
      ninja
      pkg-config
      gdb
      lldb
      valgrind
      boost
      glfw3
      glm
    ];
  };
}