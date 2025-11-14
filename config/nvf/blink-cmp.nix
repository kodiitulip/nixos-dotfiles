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
      setupOpts = {
        fuzzy.implementation = "prefer_rust_with_warning";
        cmdline.keymap.preset = "cmdline";
        cmdline.keymap = {
          "<Right>" = false;
          "<Left>" = false;
        };
        keymap = {
          preset = "enter";
          "<C-y>" = "select_and_accept";
        };
      };
      sourcePlugins.lspkind.enable = true;

    };

    keymaps = [
    ];
  };
}
