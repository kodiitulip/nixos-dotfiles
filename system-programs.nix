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
  starship.enable = true;
  kdeconnect.enable = true;
  steam.enable = true;
  steam.protontricks.enable = true;
  zoxide.enable = true;
  yazi.enable = true;
  npm.enable = true;
  lazygit.enable = true;
  xwayland.enable = true;
}
