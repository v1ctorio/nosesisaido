# Edet this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, pkgs-unstable, pkgs-stable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../modules/gaming.nix
     # ../modules/virtualization/virtual.nix
    ];


  networking.hostName = "nosesisaid"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;


  environment.systemPackages = with pkgs; [
    jdk17
    jdk21
    android-tools
    pcscliteWithPolkit
    ffmpeg
    sbctl

    hunspell
    nuspell
    hunspellDicts.en_US
    hunspellDicts.es_ES

    godot_4
  ];

    #services.kbfs = {
   #   enable = true;
  #    mountPoint = "%t/kbfs";
 #     extraFlags = [ "-label %u" ];
#
 #     };

#    services.keybase.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 8554 25565];
  #inetworking.firewall.allowedUDPPorts = [ 8554 25565];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?


  security.pam.services.gdm.enableGnomeKeyring = true;
  # Eneable NTFS support
  boot.supportedFilesystems = [ "ntfs" ];




  #virtualisation.docker.enable = true;


  boot.loader.systemd-boot.configurationLimit = 7;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  nix.settings.auto-optimise-store = true;



#  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.gamemode.enable = true;


  # adguard home 
  # this not working networking.nameservers = [ "192.168.1.155" "1.1.1.1" ];

}
