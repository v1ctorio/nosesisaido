# Edet this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nosesisaid"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  security.polkit.enable = true;
    # Configure keymap in X11
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
                "qtwebkit-5.212.0-alpha4"
              ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vic = {
    isNormalUser = true;
    description = "Victorio";
    extraGroups = [ "networkmanager" "wheel" ];

  };


# Allow unfree packages
nixpkgs.config.allowUnfree = true;




  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neofetch
    kitty
    neovim
    hyprpaper
    mpvpaper
    swww
    swaynotificationcenter
    waybar
    font-awesome
    wofi
    xdg-desktop-portal-hyprland
    grim
    slurp
    yadm
    pavucontrol
    pamixer
    polkit_gnome
    kate
    rofi-wayland
    git
    alsa-utils
    jdk17
    #wineWowPackages.waylandFull
    android-tools
    mpv
    nodejs_21
    pcscliteWithPolkit
    ffmpeg

    keybase-gui

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
  networking.firewall.allowedTCPPorts = [ 8554 ];
  networking.firewall.allowedUDPPorts = [ 8554 ];
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
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

# keybase config
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

  # Enable hyprland
  programs.hyprland.enable = true;

  services.gnome = { 
    gnome-keyring.enable = true;
  };
  security.pam.services.login.enableGnomeKeyring = true;


  programs.waybar = {
    enable = true;
  };


  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
  nerdfonts
  ];


  programs.adb.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    package = pkgs._1password-gui-beta;
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "vic" ];
  };

  programs.bash = {
    interactiveShellInit = ''
      export PATH=~/.npm-packages/bin:$PATH
      export NODE_PATH=~/.npm-packages/lib/node_modules
      export PATH=~/.yarn/bin:$PATH
      export PATH=~/.npm-global/bin:$PATH

        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  

  programs.nix-ld.enable = true;


  # automount USBs ?
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "vic" ];

  services.hardware.openrgb.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play

    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };




#  environment.sessionVariables.NIXOS_OZONE_WL = "1";
#
}
