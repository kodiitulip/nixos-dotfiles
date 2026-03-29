{ pkgs, ... }:

{
  programs = {
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
          email = "kodii.tulip@proton.me";
        };
      };
    };
    kdeconnect.enable = true;
    steam = {
      enable = true;
      protontricks.enable = true;
    };
    gamemode.enable = true;
    npm.enable = true;
    lazygit = {
      enable = true;
      settings = {
        os.openCommand = "sh -c \"xdg-open {{filename}} >/dev/null\"";
        os.openLink = "sh -c \"xdg-open {{link}} >/dev/null\"";
      };
    };
    xwayland.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };
    screen = {
      enable = true;
      screenrc = ''
        attrcolor b ".I"
        termcapinfo xterm 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'
        termcapinfo xterm|xterms|xs|rxvt ti@:te@
        defbce "on"
        term xterm-256color
        defscrollback 30000
        hardstatus alwayslastline
        hardstatus string '%{= Kd} %{= Kd}%-w%{= Kr}[%{= KW}%n %t%{= Kr}]%{= Kd}%+w %-= %{KG} %H%{KW}|%{KY}%101`%{KW}|%D %M %d %Y%{= Kc} %C%A%{-}'
        bind f eval "hardstatus ignore"
        bind F eval "hardstatus alwayslastline"
        startup_message off
      '';
    };

    nixvim = {
      enable = true;
      defaultEditor = true;
      nixpkgs.useGlobalPackages = true;
      imports = [ ./config/nixvim ];
    };

    # nix-ld = {
    # enable = true;
    # libraries = with pkgs; [
    # fontconfig
    # wayland
    # libx11
    # libdecor
    # libxcursor
    # libuiohook
    # libxext
    # libxfixes
    # libxi
    # libxinerama
    # libxkbcommon
    # libxrandr
    # libxrender
    # alsa-lib
    # libGL
    # vulkan-loader
    # fontconfig.lib
    # libpulseaudio
    # speechd-minimal
    # udev
    # ];
    # };
  };
}
