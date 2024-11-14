{ config, pkgs, pkgs-unstable, inputs, ... }: 

{
  users.users.vic.extraGroups = [ "libvirtd" ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

}
