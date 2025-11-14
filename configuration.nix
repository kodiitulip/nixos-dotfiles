{
  pkgs,
  inputs,
  config,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
  ];
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/kodie/.config/sops/age/keys.txt";
    age.generateKey = true;

    secrets.playitgg = {
      owner = config.users.users.playit.name;
    };
  };

  boot = {

    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

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

    displayManager.ly.enable = true;
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
      user = "playit";
      group = "playit";
      secretPath = config.sops.secrets.playitgg.path;
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

    playit = {
      home = "/var/lib/playit";
      createHome = true;
      isSystemUser = true;
      group = "playit";
    };
  };

  users.groups.playit = { };

  programs = import ./system-programs.nix { inherit pkgs; };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = import ./system-packages.nix { inherit pkgs inputs; };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "25.05"; # WARN: DO NOT CHANGE! NO NEED TO!
}
