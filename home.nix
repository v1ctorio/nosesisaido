{ config, pkgs, pkgs-unstable, inputs, ... }: 
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  #imports = [ inputs.spicetify-nix.homeManagerModule ];
  imports = [ 
    ./modules/hypr/hypr.nix
    ./modules/wallpapers/wallpapers.nix
    ./modules/rice/rice.nix
     ];


  home.username = "vic";
  home.homeDirectory = "/home/vic";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    ungoogled-chromium
    vscode
    pkgs-unstable.zed-editor

    pkgs-unstable.legcord
    kooha
    pkgs-unstable.prismlauncher
    #TODO: make this work yubioath-flutter
    pkgs-unstable.obsidian
    pkgs-unstable.vivaldi
    pkgs-unstable.gnome-sound-recorder

    mpc-cli
    gnome-solanum
    
    feishin
    # Emulation
    #cemu
    #anki-bin
    #katawa-shoujo-re-engineered

    palemoon-bin


    neofetch
    bat
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    pkgs-unstable.gh # GitHub CLI

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    nmap # A utility for network discovery and security auditing

    # misc
    gnupg

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon


    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    nh
    comma

   brave

   helix-gpt
   termius
   antares
   slack
   doppler
   youtube-music


  # absolute crap
  zoom-us
  
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "everforest_dark";
    };
  };

 # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "vic";
    userEmail = "74506415+v1ctorio@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      gpg.format = "ssh";
      core.editor = "nvim";
    };
  };

  programs.ssh = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    font.name = "CaskaydiaCoveNerdFont";
    shellIntegration.enableFishIntegration = true;
    settings = {
      confirm_os_window_close = 0;
    };
  };
  
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    bash.enable = true; 
  };
  programs.fish = {
    enable = true;
    functions = {
      rebootuefi = "echo 'rebooting to UEFI...'; sudo systemctl reboot --firmware-setup";
      tilderadio = "mpv https://azuracast.tilderadio.org/radio/8000/radio.ogg";
      windowstime = "echo 'rebooting to windows...'; sudo systemctl reboot --boot-loader-entry=auto-windows";
    };
  };


  home.pointerCursor = {
  gtk.enable = true;
  x11.enable = true;
  package = pkgs.bibata-cursors;
  name = "Bibata-Modern-Classic";
  size = 10;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";

    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
	  };


/*
  programs.spicetify =
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        keyboardShortcut
        adblock
      ];
    };
*/ 

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
