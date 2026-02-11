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

    playit = {
      enable = false;
      secretPath = config.sops.secrets.playitgg.path;
    };

    qbittorrent.enable = false;

    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };

    vintagestory = {
      enable = false;
      openFirewall = true;
    };

    zerotierone.enable = true;
  };
}
