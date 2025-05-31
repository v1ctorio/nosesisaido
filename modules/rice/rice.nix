{ config, home, pkgs, pkgs-unstable, inputs, ... }: 
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.file.".config/tofi/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconf/modules/rice/tofi";
  home.file.".config/waybar/".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconf/modules/rice/waybar";
  
  
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
