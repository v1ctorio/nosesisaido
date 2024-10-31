
{ config, pkgs, inputs, pkgs-unstable, pkgs-stable, ... }:

{
  imports = [
	./hardware-configuration.nix
	    ];
  networking.hostName = "alum";

  environment.systemPackages = with pkgs; [
    jdk21
    brightnessctl
  ];

  programs.sway.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true; # adds pkgs.xdg-desktop-portal-wlr to extraPortals
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk # gtk portal needed to make gtk apps happy
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  system.stateVersion = "24.05";
}
