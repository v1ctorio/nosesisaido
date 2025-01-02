{ config, home, pkgs, pkgs-unstable, inputs, ... }: 
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.file.".config/tofi/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/rice/tofi";
  home.file.".config/waybar/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/rice/waybar";
  home.file.".config/wofi/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/rice/wofi";
  
  home.file.".config/ags/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/rice/ags";
  
  programs.waybar.enable = true;
  programs.wofi.enable = true;
  programs.tofi.enable = true;
  home.packages = with pkgs-unstable; [
    hyprpaper
    mpvpaper
    swww
    dunst #swaynotificationcenter
    
    font-awesome
    
    wlogout
    
  ];
}
