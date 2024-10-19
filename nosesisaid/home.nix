{ config, pkgs, pkgs-unstable, inputs, ... }: 
{
  imports = [ 
    ../home.nix
    ];
  home.packages = with pkgs-unstable; [
    
    dissent
    fractal
    ryujinx
    osu-lazer-bin
    audio-sharing
    telegram-desktop

  ];
}