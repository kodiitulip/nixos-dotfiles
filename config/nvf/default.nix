{ pkgs, lib, ... }:

{
  imports = [
    ./lsp
    ./snacks.nix
    ./blink-cmp.nix
  ];
  vim = {
    theme = {
      enable = true;
      name = "rose-pine";
      style = "moon";
    };

    statusline.lualine.enable = true;
  };
}
