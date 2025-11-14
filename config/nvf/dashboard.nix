{ pkgs, lib, ... }:

{
  vim.dashboard = {
    dashboard-nvim.enable = true;
    dashboard-nvim.setupOpts = {
      theme = "doom";
      hide = {
        statusline = false;
      };
      config = {
        header = ''

          ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
          ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
          ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
          ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
          ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
          ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
        '';
        center = [
          {
            action = "lua LazyVim.pick()()";
            desc = " Find File";
            icon = " ";
            key = "f";
          }
          {
            action = "ene | startinsert";
            desc = " New File";
            icon = " ";
            key = "n";
          }
          {
            action = "lua LazyVim.pick(\"oldfiles\")()";
            desc = " Recent Files";
            icon = " ";
            key = "r";
          }
          {
            action = "lua LazyVim.pick(\"live_grep\")()";
            desc = " Find Text";
            icon = " ";
            key = "g";
          }
          {
            action = "lua LazyVim.pick.config_files()()";
            desc = " Config";
            icon = " ";
            key = "c";
          }
          {
            action = "lua require(\"persistence\").load()";
            desc = " Restore Session";
            icon = " ";
            key = "s";
          }
          {
            action = "LazyExtras";
            desc = " Lazy Extras";
            icon = " ";
            key = "x";
          }
          {
            action = "Lazy";
            desc = " Lazy";
            icon = "󰒲 ";
            key = "l";
          }
          {
            action = lib.generators.mkLuaInline ''function() vim.api.nvim_input("<cmd>qa<cr>") end'';
            desc = " Quit";
            icon = " ";
            key = "q";
          }
        ];
        footer = "⚡ Neovim loaded ";
      };
    };
  };
}
