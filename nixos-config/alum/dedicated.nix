
{ config, pkgs, inputs, pkgs-unstable, pkgs-stable, ... }:

{
  imports = [
	./hardware-configuration.nix
	    ];
  networking.hostName = "alum";

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  system.stateVersion = "24.05";
}
