{ pkgs, lib, ... }:

{
  vim.notes.todo-comments = {
    enable = true;
  };

  vim.keymaps = [
    { 
      key = "]t";
      action = ''function() require("todo-comments").jump_next() end'';
      desc = "Next Todo Comment";
      lua = true;
      mode = "n";
    }
    { 
      key = "[t";
      action = ''function() require("todo-comments").jump_prev() end'';
      desc = "Previous Todo Comment";
      lua = true;
      mode = "n";
    }
    { 
      key = "<leader>xt";
      action = "<cmd>Trouble todo toggle<cr>";
      desc = "Todo (Trouble)";
      mode = "n";
    }
    { 
      key = "<leader>xT";
      action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
      desc = "Todo/Fix/Fixme (Trouble)";
      mode = "n";
    }
    { 
      key = "<leader>st";
      action = "<cmd>TodoTelescope<cr>";
      desc = "Todo";
      mode = "n";
    }
    { 
      key = "<leader>sT";
      action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
      desc = "Todo/Fix/Fixme";
      mode = "n";
    }
  ];
}