# Edet this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, pkgs-unstable, pkgs-stable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.overlays = [
    inputs.webx.overlays.x86_64-linux.default
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

    keybase-gui

    sbctl

    hunspell
    nuspell
    hunspellDicts.en_US
    hunspellDicts.es_ES

    webx
    godot_4
  ];

    services.kbfs = {
      enable = true;
      mountPoint = "%t/kbfs";
      extraFlags = [ "-label %u" ];

      };

    services.keybase.enable = true;

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
  networking.firewall.allowedTCPPorts = [ 8554 25565];
  networking.firewall.allowedUDPPorts = [ 8554 25565];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?


systemd = {

 user.services = {
    keybase.serviceConfig.Slice = "keybase.slice";

    kbfs = {
      environment = { KEYBASE_RUN_MODE = "prod"; };
      serviceConfig.Slice = "keybase.slice";
    };

    keybase-gui = {
      description = "Keybase GUI";
      requires = [ "keybase.service" "kbfs.service" ];
      after    = [ "keybase.service" "kbfs.service" ];
      serviceConfig = {
        ExecStart  = "${pkgs.keybase-gui}/share/keybase/Keybase";
        PrivateTmp = true;
        Slice      = "keybase.slice";
      };
    };
  };
};
  security.pam.services.gdm.enableGnomeKeyring = true;
  # Eneable NTFS support
  boot.supportedFilesystems = [ "ntfs" ];




  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "vic" ];

  services.hardware.openrgb.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play

    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  boot.loader.systemd-boot.configurationLimit = 7;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  nix.settings.auto-optimise-store = true;


  # Potentially enable Pro Controller support (?)
  hardware.steam-hardware.enable = true;



#  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.gamemode.enable = true;



}
