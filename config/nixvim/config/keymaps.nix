_: {
  keymaps = [
    {
      key = "<leader>p";
      mode = [ "n" ];
      action = "<cmd>YankyRingHistory<CR>";
    }
    {
      key = "<c-s>";
      mode = [ "i" ];
      action = "<esc><cmd>w<cr>i";
    }
    {
      key = "<c-s>";
      mode = [ "n" ];
      action = "<esc><cmd>w<cr>";
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
  ];
}
