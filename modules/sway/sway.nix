{ config, home, pkgs, pkgs-unstable, inputs, ... }: 
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.file.".config/sway/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/sway/sway";
  home.file.".config/yambar/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/sway/yambar";
  programs.yambar.enable = true;
  
  home.packages = with pkgs-unstable; [
    mako
  ];
}
