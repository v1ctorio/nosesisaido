{ config, home, pkgs, pkgs-unstable, inputs, ... }: 

{
  home.file.".config/Pictures/wallpapers".source = ./Images;
  home.file.".config/Videos/wallpapers".source = ./Videos;
}