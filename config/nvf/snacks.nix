{ pkgs, lib, ... }:

{
  vim = {
    utility.snacks-nvim.enable = true;
    utility.snacks-nvim.setupOpts = {
      bigfile.enabled = true;
      explorer.enabled = true;
      indent.enabled = true;
      input.enabled = true;
      notifier = {
        enabled = true;
        timeout = 3000;
      };
      picker.enabled = true;
      quickfile.enabled = true;
      scope.enabled = true;
      scroll.enabled = true;
      statuscolumn.enabled = true;
      words.enabled = true;
    };

    keymaps = [
      {
        key = "<leader>e";
        mode = "n";
        action = ''function() Snacks.explorer() end'';
        desc = "Explorer Snacks (cwd)";
        lua = true;
      }
      {
        key = "<leader><space>";
        mode = "n";
        action = "function() Snacks.picker.smart() end";
        lua = true;
        desc = "Smart Find Files";
        noremap = false;
      }
      {
        key = "<leader>/";
        mode = "n";
        action = ''function() Snacks.picker.grep() end'';
        lua = true;
        desc = "Smart Find Files";
        noremap = false;
      }
    ];
  };
}
