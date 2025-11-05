{
  enable = true;
  settings.vim = {
    theme = {
      enable = true;
      name = "rose-pine";
      style = "moon";
    };

    tabline.nvimBufferline.enable = true;
    statusline.lualine.enable = true;
    autocomplete.blink-cmp.enable = true;
    autocomplete.blink-cmp.friendly-snippets.enable = true;
    formatter.conform-nvim.enable = true;
    binds.whichKey.enable = true;
    ui.noice.enable = true;
    ui.noice.setupOpts.presets.inc_rename = true;
    notes.todo-comments.enable = true;
    lsp.trouble.enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    treesitter.autotagHtml = true;
    autopairs.nvim-autopairs.enable = true;

    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
      mappings.open = "<c-/>";
    };

    utility = {
      snacks-nvim.enable = true;
      motion.flash-nvim.enable = true;
      yanky-nvim.enable = true;
      yanky-nvim.setupOpts.ring.storage = "sqlite";
    };

    languages = {
      enableFormat = true;

      nix.enable = true;
      nix.extraDiagnostics.enable = true;
      lua.enable = true;
      lua.lsp.lazydev.enable = true;
      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
        format.type = "biome";
      };
      html.enable = true;
      css.enable = true;
      css.format.type = "biome";
      tailwind.enable = true;
      python.enable = true;
      rust.enable = true;
      rust.crates.enable = true;
      java.enable = true;
      yaml.enable = true;
      markdown.enable = true;
      markdown.extensions.markview-nvim.enable = true;
      nu.enable = true;
    };

    mini = {
      hipatterns.enable = true;
      icons.enable = true;
      ai.enable = true;
      animate.enable = true;
      comment.enable = true;
      indentscope.enable = true;
      pairs.enable = true;
      snippets.enable = true;
      surround.enable = true;
    };
  };
}
