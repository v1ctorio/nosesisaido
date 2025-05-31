{ config, pkgs, pkgs-stable, pkgs-unstable, inputs, ... }: 
{
  imports = [ 
    ../home.nix
    ../modules/sway/sway.nix
    ];
  home.packages = with pkgs-unstable; [
pkgs-stable.bottles
    
    #jetbrains.rust-rover
    #jetbrains.datagrip
    deno
    #pkgs-stable.ryujinx
    telegram-desktop

  ];
}
