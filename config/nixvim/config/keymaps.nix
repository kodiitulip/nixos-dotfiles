{ lib, ... }:
{
  keymaps = [
    {
      key = "<leader>p";
      mode = [ "n" ];
      action = "<cmd>YankyRingHistory<CR>";
    }
    {
      key = "<c-s>";
      mode = [
        "i"
        "x"
        "n"
        "s"
      ];
      action = "<cmd>w<cr><esc>";
      options.desc = "Save File";
    }
    {
      key = "jk";
      mode = [ "i" ];
      action = "<esc>";
    }
    {
      key = "<leader>qq";
      mode = [ "n" ];
      action = "<cmd>qa<CR>";
    }
    {
      key = "<c-h>";
      mode = [ "n" ];
      action = "<c-w>h";
      options.desc = "Go to the Left Window";
    }
    {
      key = "<c-l>";
      mode = [ "n" ];
      action = "<c-w>l";
      options.desc = "Go to the Right Window";
    }
    {
      key = "<c-j>";
      mode = [ "n" ];
      action = "<c-w>j";
      options.desc = "Go to the Left Window";
    }
    {
      key = "<c-h>";
      mode = [ "n" ];
      action = "<c-w>h";
      options.desc = "Go to the Left Window";
    }
    {
      key = ">";
      mode = [ "x" ];
      action = ">gv";
    }
    {
      key = "<";
      mode = [ "x" ];
      action = "<gv";
    }
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<esc>";
      action = lib.nixvim.utils.mkRaw ''
                function()
        					vim.cmd("noh")
        					return "<esc>"
        				end '';
      options = {
        expr = true;
        desc = "Escape and Clear hlsearch";
      };
    }
  ];
}
