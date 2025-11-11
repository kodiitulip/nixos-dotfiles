{ pkgs, lib, ... }:

{
  vim = {
    extraPlugins = with pkgs.vimPlugins; {
      blink-ripgrep-nvim = {
        package = blink-ripgrep-nvim;
      };
    };

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      mapings = { };

      setupOpts.fuzzy.implementation = "prefer_rust_with_warning";
    };

    keymaps = [
      {
        key = "<leader>fe";
        mode = "n";
        action = "function() Snacks.explorer({ cwd = LazyVim.root() }) end";
        desc = "Explorer Snacks (root dir)";
        lua = true;
      }
    ];
  };
}
