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
        truecolor on
        term screen-256color
        attrcolor b ".I"
        defbce on
        termcapinfo xterm 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'

        altscreen on
        defscrollback 10000
        startup_message off

        # Pass through terminal type to inner applications
        termcapinfo xterm*|rxvt*|putty* 'is=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;3;4;6l\E[4l\E[?1000h\E[?25h'
      '';
    };

    nixvim = {
      enable = true;
      defaultEditor = true;
      nixpkgs.useGlobalPackages = true;
      imports = [ ./config/nixvim ];
    };
  };
}
