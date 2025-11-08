{ pkgs, ... }:
{
  keymaps = [
    {
      key = "<leader>p";
      mode = [ "n" ];
      action = "<cmd>YankyRingHistory<CR>";
    }
    {
      key = "<leader>qq";
      mode = [ "n" ];
      action = "<cmd>qa<CR>";
    }
    {
      key = "jk";
      mode = [ "i" ];
      action = "<c-\><c-n>";
    }
    {
      key = "<c-s>";
      mode = [
        "n"
        "i"
        "x"
      ];
      action = "<cmd>w<cr>";
    }
    {
      key = "<c-h>";
      mode = [ "n" ];
      action = "<c-w>h";
    }
    {
      key = "<c-j>";
      mode = [ "n" ];
      action = "<c-w>j";
    }
    {
      key = "<c-k>";
      mode = [ "n" ];
      action = "<c-w>k";
    }
    {
      key = "<c-l>";
      mode = [ "n" ];
      action = "<c-w>l";
    }
  ];
}
