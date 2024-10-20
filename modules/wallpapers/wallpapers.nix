{ config, home, pkgs, pkgs-unstable, inputs, ... }: 

{
  home.file."Pictures/wallpapers".source = ./Images;
  home.file."Videos/wallpapers".source = ./Videos;
}
