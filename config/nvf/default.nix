{ pkgs, lib, ... }:

{
  imports = [
    ./lsp
    ./snacks.nix
    ./blink-cmp.nix
    ./mini.nix
    ./dashboard.nix
  ];
  vim = {
    theme = {
      enable = true;
      name = "rose-pine";
      style = "moon";
    };

    statusline.lualine.enable = true;

    keymaps = [
      {
        key = "<leader>qq";
        mode = "n";
        action = "<cmd>qa<cr>";
        desc = "Exit all";
      }
    ];
  };
}
