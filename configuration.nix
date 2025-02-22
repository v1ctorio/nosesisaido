# Edet this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, pkgs-unstable, pkgs-stable, ... }:

{

  nix.package = pkgs.lix;

  imports = [
    ./modules/firefox.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    builders-use-substitutes = true;
    # extra substituters to add
    extra-substituters = [
    ];

    extra-trusted-public-keys = [
    ];

  };

  nix.trustedUsers = [ "root" "vic" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    UseDns = true;
    X11Forwarding = true;
    PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "es_ES.UTF-8/UTF-8" ];
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
  services.xserver.desktopManager.gnome.enable = true;


  security.polkit.enable = true;
    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };


  # Enable sound with pipewire.
  # disable sound.enable ?? sound.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "ydotool" ];

  };

programs.ydotool.enable = true;

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

  # Add Nosesisaid root CA
  security.pki.certificates = [
    ''
    NSSID
    =========
      -----BEGIN CERTIFICATE-----
MIID0TCCArmgAwIBAgIUAyr5VWp2Rnif5kvSqfNlsmMvu9cwDQYJKoZIhvcNAQEL
BQAweDELMAkGA1UEBhMCRVMxDzANBgNVBAgMBk1hZHJpZDEPMA0GA1UEBwwGTWFk
cmlkMRMwEQYDVQQKDApOb3Nlc2lzYWlkMQ4wDAYDVQQDDAVOU1NJRDEiMCAGCSqG
SIb3DQEJARYTY2VydEBub3Nlc2lzYWlkLmNvbTAeFw0yNDEyMTUwNzQ0MzlaFw0y
OTEyMTQwNzQ0MzlaMHgxCzAJBgNVBAYTAkVTMQ8wDQYDVQQIDAZNYWRyaWQxDzAN
BgNVBAcMBk1hZHJpZDETMBEGA1UECgwKTm9zZXNpc2FpZDEOMAwGA1UEAwwFTlNT
SUQxIjAgBgkqhkiG9w0BCQEWE2NlcnRAbm9zZXNpc2FpZC5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCzGRgnptSvu2wWB4Ic/W1myyugRlteuX14
XQ6ixv1vmqmbp5rh24vbzXqPfo5n1H6Em1ELaub8TRkhPzjOGM3FctIPNwtiRREE
39735o6LyqG4G6Nfi1ybu4HtTk1Jyx5l6WRrx+yxqX4mzpdTqaGWMipFKoZSwZR8
fyRGtzOnXrNw1nyjy8Pja3hdPrHlDG5XfRNtNuFafsa0KDuFd0v5CigFgqkbS/Kv
Y4xJD6i5Y8EHX56l2cHbLlsc5+kgGA/8N6u4K6x9crnsOyxw0vce99T5/fnGK0B7
RuOySfGkD0x1zaoiddjrXSO6waaDHZzBvdh7IZkyO1NKjcTvLDGXAgMBAAGjUzBR
MB0GA1UdDgQWBBTvT+in85GCBNYSDdU1KH38xqGAPDAfBgNVHSMEGDAWgBTvT+in
85GCBNYSDdU1KH38xqGAPDAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
A4IBAQBjIovW+PuW+KBI9O+DhvTr5nV5/QDiAjvDEVNpSFLkx8dvP5RFmaYnUZuK
UZcAi5OHwg+X6updvZnUYSYYKFqkWi1K5PflZ6qa64bWy2mhcFiksBsXUhkUhR00
OlimNwPvjfeLcK8qy7Pv1rU+dORYOmxqPFDZp1hD74gAvofGzRH61rOa6bRauapK
TFfyr0UU7feY8sDjjs2PS+iACyP7Wegk5T0939IYOM+//pvQE08uopzuasGQwSxB
Fki40Y0Psseum1o6KwGVwR6yDnX3fZBqNFDVok5sNnGnK4IvmJu370nstoMDiHCE
p9fGSQgaH0TZi3lDRt9P3X9rN25d
-----END CERTIFICATE-----
    ''
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neofetch
    neovim
    grim
    slurp
    pavucontrol
    pamixer
    polkit_gnome
    kate
    git
    alsa-utils
    mpv
    nodejs_22
    ffmpeg-full

    wl-clipboard

    sbctl

    hunspell
    nuspell
    hunspellDicts.en_US
    hunspellDicts.es_ES
    gcc
    
    restic
    resticprofile
playerctl
    pkgs-unstable.cargo
    pkgs-unstable.rust-analyzer
    pkgs-unstable.rustfmt
    pkgs-unstable.rustc

    
  ];


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

  # Login manager/Display manager
  services.displayManager.ly.enable = true;


  programs._1password= {
    enable = true;
    package = pkgs-unstable._1password-cli;
  };
  programs._1password-gui = {
    package = pkgs-stable._1password-gui;
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "vic" ];
  };

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
	};

  security.pam.services.gdm.enableGnomeKeyring = true;

  # Enable hyprland
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  programs.light.enable = true;

  services.gnome = { 
    gnome-keyring.enable = true;
  };
  security.pam.services.login.enableGnomeKeyring = true;

security.pam.yubico = {
   enable = true;
   debug = false;
   mode = "challenge-response";
   id = [ "22925810" ];# Yubi USB A
};




  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
  nerd-fonts.fira-code
  nerd-fonts.caskaydia-cove
  nerd-fonts.lilex
  noto-fonts-cjk-sans
  ];


  programs.adb.enable = true;

  environment.etc = {
    "1passowrd/custom_allowed_browsers" = {
      text = ''
      firefox
      vivaldi
      .zen-wrapped
       '';
      mode = "0755";
    };
  };

  programs.bash = {
    interactiveShellInit = ''
      export PATH=~/.npm-packages/bin:$PATH
      export NODE_PATH=~/.npm-packages/lib/node_modules
      export PATH=~/.yarn/bin:$PATH
      export PATH=~/.npm-global/bin:$PATH
      export PATH=~/.cargo/bin:$PATH
      export PATH=~/go/bin:$PATH
      export PATH=~/.local/bin:$PATH
      export TERM=kitty
      export EDITOR=hx


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

  
  services.pcscd.enable = true;

  


}
