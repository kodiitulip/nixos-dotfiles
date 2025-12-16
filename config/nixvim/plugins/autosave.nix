{
  plugins.auto-save = {
    enable = false;
  };
  keymaps = [
    {
      key = "<C-s>";
      mode = [ "i" ];
      action = "<esc><cmd>ASToggle<CR>";
    }
    {
      key = "<C-s>";
      mode = [ "n" ];
      action = "<cmd>ASToggle<CR>";
    }
  ];
}
