{ config, home, pkgs, pkgs-unstable, inputs, ... }: 
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.file.".config/hypr/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/hypr/hypr";
  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
  ];
}
