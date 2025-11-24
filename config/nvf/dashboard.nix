{ pkgs, lib, ... }:
let
  logo = ''
                                                              
    @@@  @@@  @@@@@@@@   @@@@@@   @@@  @@@  @@@  @@@@@@@@@@   
    @@@@ @@@  @@@@@@@@  @@@@@@@@  @@@  @@@  @@@  @@@@@@@@@@@  
    @@!@!@@@  @@!       @@!  @@@  @@!  @@@  @@!  @@! @@! @@!  
    !@!!@!@!  !@!       !@!  @!@  !@!  @!@  !@!  !@! !@! !@!  
    @!@ !!@!  @!!!:!    @!@  !@!  @!@  !@!  !!@  @!! !!@ @!@  
    !@!  !!!  !!!!!:    !@!  !!!  !@!  !!!  !!!  !@!   ! !@!  
    !!:  !!!  !!:       !!:  !!!  :!:  !!:  !!:  !!:     !!:  
    :!:  !:!  :!:       :!:  !:!   ::!!:!   :!:  :!:     :!:  
    ::   ::   :: ::::  ::::: ::    ::::     ::  :::     ::   
    ::    :   : :: ::    : :  :      :      :     :      :   
  '';
in
{
  vim.dashboard = {
    dashboard-nvim.enable = true;
    dashboard-nvim.setupOpts = {
      theme = "doom";
      config = {
        header = lib.generators.mkLuaInline ''vim.split(string.rep("\n", 4) .. [[${logo}]] .. string.rep("\n", 4), "\n")'';
        center = [
          {
            action = "lua Snacks.picker.smart()";
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
            action = "lua Snacks.picker.pick(\"oldfiles\")";
            desc = " Recent Files";
            icon = " ";
            key = "r";
          }
          {
            action = "lua Snacks.picker.grep()";
            desc = " Find Text";
            icon = " ";
            key = "g";
          }
          {
            action = "lua require(\"persistence\").load()";
            desc = " Restore Session";
            icon = " ";
            key = "s";
          }
          {
            action = "lua Snacks.picker.projects()";
            desc = " Projects";
            icon = " ";
            key = "p";
          }
          {
            action = lib.generators.mkLuaInline ''function() vim.api.nvim_input("<cmd>qa<cr>") end'';
            desc = " Quit";
            icon = " ";
            key = "q";
          }
        ];
        footer = ["⚡ Neovim loaded"];
        vertical_center = true;
      };
    };
    
  };
}
