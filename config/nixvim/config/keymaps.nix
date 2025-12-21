{ lib, ... }:
{
  keymaps = [
    # better up/down
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        desc = "Down";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        desc = "Down";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        desc = "Up";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        desc = "Up";
        expr = true;
        silent = true;
      };
    }

    # Move to window using the <ctrl> hjkl keys
    {
      mode = [ "n" ];
      key = "<c-h>";
      action = "<c-w>h";
      options = {
        desc = "Go to Left Window";
        remap = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<c-j>";
      action = "<c-w>j";
      options = {
        desc = "Go to Down Window";
        remap = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<c-k>";
      action = "<c-w>k";
      options = {
        desc = "Go to Up Window";
        remap = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<c-l>";
      action = "<c-w>l";
      options = {
        desc = "Go to Right Window";
        remap = true;
      };
    }

    # Move lines

    {
      mode = [ "n" ];
      key = "<A-j>";
      action = "<cmd>execute 'move .+' . v:count1<cr>==";
      options = {
        desc = "Move Down";
        silent = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<A-k>";
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
      options = {
        desc = "Move Up";
        silent = true;
      };
    }
    {
      mode = [ "i" ];
      key = "<A-j>";
      action = "<esc><cmd>m .+1<cr>==gi";
      options = {
        desc = "Move Down";
        silent = true;
      };
    }
    {
      mode = [ "i" ];
      key = "<A-k>";
      action = "<esc><cmd>m .-2<cr>==gi";
      options = {
        desc = "Move Up";
        silent = true;
      };
    }
    {
      mode = [ "v" ];
      key = "<A-j>";
      action = ":<C-u>execute \"'<;'>move '>+\" . v:count1<cr>gv=gv";
      options = {
        desc = "Move Down";
        silent = true;
      };
    }
    {
      mode = [ "v" ];
      key = "<A-k>";
      action = ":<C-u>execute \"'<;'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
      options = {
        desc = "Move Up";
        silent = true;
      };
    }

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

    # Add undo breakpoints

    {
      mode = [ "i" ];
      key = ",";
      action = ",<c-g>u";
    }
    {
      mode = [ "i" ];
      key = ".";
      action = ".<c-g>u";
    }
    {
      mode = [ "i" ];
      key = ";";
      action = ";<c-g>u";
    }
  ];
}
