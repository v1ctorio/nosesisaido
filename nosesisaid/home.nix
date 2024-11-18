{ config, pkgs, pkgs-unstable, inputs, ... }: 
{
  imports = [ 
    ../home.nix
    ];
  home.packages = with pkgs-unstable; [

    rustup
    
    jetbrains.rust-rover
    deno
    ryujinx
    osu-lazer-bin
    audio-sharing
    telegram-desktop

  ];
}
