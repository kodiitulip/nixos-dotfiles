{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "dioxus-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "mrxiaozhuox";
        repo = "dioxus.nvim";
        rev = "311558c09951da3c23d8feb830c48629cdb42db4";
        hash = "sha256-T0e1ycAE0Gnb2adCoLwM3IpfyOREqQhl/2nNqcoLuUE=";
      };
      nvimSkipModules = [ "dioxus" ];
    })
  ];
}
