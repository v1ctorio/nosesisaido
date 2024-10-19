{ lib, pkgs-stable, pkgs-unstable, inputs, ...}:
{
  hardware.steam-hardware.enable = true;  
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play

    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  #environment.systemPackages = [
   # pkgs-stable.sunshine
  #];

  #security.wrappers.sunshine = {
     # owner = "root";
    #  group = "root";
   #   capabilities = "cap_sys_admin+p";
  #    source = "${pkgs-stable.sunshine}/bin/sunshine";
 # };

  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    
  };

  hardware.opengl.extraPackages = with pkgs-stable; [
    amdvlk
  ];
  hardware.opengl.enable = true;


}
