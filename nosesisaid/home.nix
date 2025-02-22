{ config, pkgs, pkgs-stable, pkgs-unstable, inputs, ... }: 
{
  imports = [ 
    ../home.nix
    ../modules/sway/sway.nix
    ];
  home.packages = with pkgs-unstable; [
go
pkgs-stable.bottles
    rustup
    
    #jetbrains.rust-rover
    #jetbrains.datagrip
    deno
    #pkgs-stable.ryujinx
    osu-lazer-bin
    audio-sharing
    telegram-desktop

spice-gtk
virt-viewer
gnome-boxes

  ];
}
