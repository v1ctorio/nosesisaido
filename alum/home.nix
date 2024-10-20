{ config, pkgs, pkgs-unstable, inputs, ... }: 
{
  imports = [ 
    ../home.nix
    ../modules/sway/sway.nix
    ];
}
