{
  pkgs,
  inputs,
  config,
  ...
}:

{
  nixpkgs.overlays = [
    inputs.vintagestory-nix.overlays.default
    inputs.copyparty.overlays.default
  ];

  imports = [
    inputs.copyparty.nixosModules.default
    inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
  ];
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/kodie/.config/sops/age/keys.txt";
    age.generateKey = true;
    secrets = {
      playitgg.owner = config.users.users.kodie.name;
      copyparty.owner = config.users.users.copyparty.name;
    };
  };

  boot = {

    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };

  security.polkit.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services = {

    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      videoDrivers = [ "amdgpu" ];
    };

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    xserver.xkb = {
      layout = "br";
      variant = "nodeadkeys";
      options = "compose:rctrl";
    };

    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };

    flatpak.enable = true;
    openssh.enable = true;

    playit = {
      enable = true;
      secretPath = config.sops.secrets.playitgg.path;
    };

    qbittorrent.enable = true;

    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };

    copyparty = {
      enable = true;
      user = "copyparty";
      group = "copyparty";
      settings = {
        i = "0.0.0.0";
        p = [
          3210
          3211
        ];
        no-reload = true;
        ignored-flag = false;
      };
      accounts = {
        kodie.passwordFile = config.sops.secrets.copyparty.path;
      };
      groups.g1 = [ "kodie" ];
      volumes."/" = {
        path = "/srv/copyparty";
        access = {
          r = "*";
          rw = [ "kodie" ];
        };
        flags = {
          e2dsa = true;
          e2ts = true;
          norobots = true;
          forcejs = true;
        };
      };
    };
  };

  xdg.icons.fallbackCursorThemes = [ "breeze_cursors" ];
  console.keyMap = "br-abnt2";
  security.rtkit.enable = true;

  users.users = {
    kodie = {
      isNormalUser = true;
      description = "Kodie Sales";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = [ ];
      shell = pkgs.nushell;
    };
    copyparty = {
      home = "/var/lib/copyparty";
      createHome = true;
      isSystemUser = true;
      group = "copyparty";
    };
  };

  users.groups.copyparty = { };

  programs = import ./system-programs.nix { inherit pkgs; };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = import ./system-packages.nix { inherit pkgs inputs; };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    comic-relief
  ];

  hardware = {
    opentabletdriver.enable = true;
    opentabletdriver.daemon.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        3000
      ];
      allowedUDPPortRanges = [
        {
          from = 4000;
          to = 4007;
        }
        {
          from = 8000;
          to = 8010;
        }
        {
          from = 25555;
          to = 25565;
        }
      ];
    };
  };

  system.stateVersion = "25.05"; # WARN: DO NOT CHANGE! NO NEED TO!
}
