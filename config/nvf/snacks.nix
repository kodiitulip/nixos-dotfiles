{ pkgs, lib, ... }:

{
  vim = {
    utility.snacks-nvim.enable = true;
    utility.snacks-nvim.setupOpts = {
      explorer = { };
    };

    keymaps = [
      {
        key = "<leader>fe";
        mode = "n";
        action = "function() Snacks.explorer({ cwd = LazyVim.root() }) end";
        desc = "Explorer Snacks (root dir)";
        lua = true;
      }
      {
        key = "<leader>fE";
        mode = "n";
        action = "function() Snacks.explorer() end";
        desc = "Explorer Snacks (cwd)";
        lua = true;
      }
      {
        key = "<leader>e";
        action = "<leader>fe";
        desc = "Explorer Snacks (root dir)";
        noremap = false;
      }
      {
        key = "<leader>E";
        action = "<leader>fE";
        desc = "Explorer Snacks (cwd)";
        noremap = false;
      }
    ];
  };
}
