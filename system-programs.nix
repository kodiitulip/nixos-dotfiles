{ pkgs, ... }:

{
  firefox = {
    enable = true;
    nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
  };
  git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };
      user = {
        name = "kodiitulip";
        email = "kodii.tulip@gmail.com";
      };
    };
  };
  kdeconnect.enable = true;
  steam = {
    enable = true;
    protontricks.enable = true;
  };
  npm.enable = true;
  lazygit.enable = true;
  lazygit.settings = {
    os.openCommand = "sh -c \"xdg-open {{filename}} >/dev/null\"";
    os.openLink = "sh -c \"xdg-open {{link}} >/dev/null\"";
  };
  xwayland.enable = true;

  neovim = {
    enable = true;
    defaultEditor = true;
  };

  appimage.enable = true;
  appimage.binfmt = true;

  nix-ld.enable = true;
  nix-ld.libraries = with pkgs; [
    fontconfig
    wayland
    libx11
    libdecor
    libxcursor
    libuiohook
    libxext
    libxfixes
    libxi
    libxinerama
    libxkbcommon
    libxrandr
    libxrender
    alsa-lib
    libGL
    vulkan-loader
    fontconfig.lib
    libpulseaudio
    speechd-minimal
    udev
  ];
}
