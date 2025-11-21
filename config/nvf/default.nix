{ pkgs, lib, ... }:

{
  imports = [
    ./lsp
    ./snacks.nix
    ./blink-cmp.nix
    ./mini.nix
    ./dashboard.nix
    ./which-key.nix
    ./gitsigns.nix
    ./todo-comments.nix
  ];
  vim = {
    theme = {
      enable = true;
      name = "rose-pine";
      style = "moon";
    };

    statusline.lualine.enable = true;

    utility.motion.flash-nvim.enable = true;

    keymaps = [
      {
        key = "<leader>qq";
        mode = "n";
        action = "<cmd>qa<cr>";
        desc = "Exit all";
      }
      {
        key = "<c-s>";
        mode = [ "n" "i" "x" ];
        action = "<c-/><c-n><cmd>w<cr>";
        desc = "Write File";
      }
      {
        key = "<c-h>";
        mode = "n";
        action = "<c-w>h";
        desc = "Go to the left window";
      }
      {
        key = "<c-H>";
        mode = "n";
        action = "<c-w>H";
        desc = "Go to the far left window";
      }
      {
        key = "<c-l>";
        mode = "n";
        action = "<c-w>l";
        desc = "Go to the right window";
      }
      {
        key = "<c-L>";
        mode = "n";
        action = "<c-w>L";
        desc = "Go to the far right window";
      }
      {
        key = "<c-k>";
        mode = "n";
        action = "<c-w>k";
        desc = "Go to the up window";
      }
      {
        key = "<c-K>";
        mode = "n";
        action = "<c-w>K";
        desc = "Go to the far up window";
      }
      {
        key = "<c-j>";
        mode = "n";
        action = "<c-w>j";
        desc = "Go to the down window";
      }
      {
        key = "<c-J>";
        mode = "n";
        action = "<c-w>J";
        desc = "Go to the far down window";
      }
    ];

    clipboard.enable = true;
    clipboard.registers = "unnamedplus";
  };
}
