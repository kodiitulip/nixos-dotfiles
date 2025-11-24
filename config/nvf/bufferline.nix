{ pkgs, lib, ... }:

{
  vim.tabline.nvimBufferline = {
    enable = true;
    mappings = {
      cyclePrevious = "<S-h>";
      cycleNext = "<S-l>";
    };
  };
  vim.keymaps = [
    { key = "<leader>bp"; action = "<Cmd>BufferLineTogglePin<CR>"; desc = "Toggle Pin"; mode = "n"; }
    { key = "<leader>bP"; action = "<Cmd>BufferLineGroupClose ungrouped<CR>"; desc = "Delete Non-Pinned Buffers"; mode = "n"; }
    { key = "<leader>br"; action = "<Cmd>BufferLineCloseRight<CR>"; desc = "Delete Buffers to the Right"; mode = "n"; }
    { key = "<leader>bl"; action = "<Cmd>BufferLineCloseLeft<CR>"; desc = "Delete Buffers to the Left"; mode = "n"; }
    { key = "<S-h>";      action = "<cmd>BufferLineCyclePrev<cr>"; desc = "Prev Buffer"; mode = "n"; }
    { key = "<S-l>";      action = "<cmd>BufferLineCycleNext<cr>"; desc = "Next Buffer"; mode = "n"; }
    { key = "[b";         action = "<cmd>BufferLineCyclePrev<cr>"; desc = "Prev Buffer"; mode = "n"; }
    { key = "]b";         action = "<cmd>BufferLineCycleNext<cr>"; desc = "Next Buffer"; mode = "n"; }
    { key = "[B";         action = "<cmd>BufferLineMovePrev<cr>"; desc = "Move buffer prev"; mode = "n"; }
    { key = "]B";         action = "<cmd>BufferLineMoveNext<cr>"; desc = "Move buffer next"; mode = "n"; }
  ];
}