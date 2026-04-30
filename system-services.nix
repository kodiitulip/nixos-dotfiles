{
  pkgs,
  config,
  ...
}:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
  };
in
{
  age.secrets.playitgg = {
    owner = "kodie";
    group = "users";
    file = ./secrets/playitgg.age;
  };
  services = {
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      videoDrivers = [ "amdgpu" ];
    };
    displayManager.sddm = {
      enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = [
        sddm-astronaut
        pkgs.kdePackages.qtmultimedia
      ];
    };
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

    qbittorrent.enable = false;

    zerotierone.enable = true;

    playit = {
      enable = false;
      secretPath = config.age.secrets.playitgg.path;
    };
  };

  environment.systemPackages = [
    sddm-astronaut
  ];
}
