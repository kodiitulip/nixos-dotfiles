{ pkgs, lib, ... }:

{
  imports = [
    ./lsp
    ./snacks.nix
    ./blink-cmp.nix
    ./mini.nix
    ./dashboard.nix
    ./which-key.nix
    ./gitsigns.nix
    ./todo-comments.nix
    ./bufferline.nix
  ];
  vim = {
    theme = {
      enable = true;
      name = "rose-pine";
      style = "moon";
    };

    formatter.conform-nvim = {
      enable = true;

    };

    statusline.lualine.enable = true;

    utility.motion.flash-nvim.enable = true;

    options = {
      autowrite = true;
      clipboard = "unnamedplus";
      completeopt = "menu,menuone,noselect";
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      expandtab = true;
      fillchars =''foldopen:;foldclose:;fold:\ ;foldsep:\ ;diff:/;eob: ;'';
      foldlevel = 99;
      foldmethod = "indent";
      foldtext = "";
      number = true;
      pumblend = 10;
      pumheight = 10;
      relativenumber = true;
      ruler = false;
      scrolloff = 4;
      sessionoptions = [
        "buffers"
        "curdir"
        "tabpages"
        "winsize"
        "help"
        "globals"
        "skiprtp"
        "folds"
      ];
      shiftround = true;
      shiftwidth = 2;
      showmode = false;
      sidescrolloff = 8;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      smoothscroll = true;
      spelllang = [
        "en"
        "pt_br"
      ];
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      undolevels = 10000;
      updatetime = 200;
      virtualedit = "block";
      winminwidth = 5;
    };

    keymaps = [
      {
        key = "<leader>qq";
        mode = "n";
        action = "<cmd>qa<cr>";
        desc = "Exit all";
      }
      {
        key = "jk";
        mode = [
          "i"
          "x"
        ];
        action = "<esc>";
        desc = "Leave Insert Mode";
      }
      {
        key = "<c-s>";
        mode = [
          "n"
          "i"
          "x"
        ];
        action = "<esc><cmd>w<cr>";
        desc = "Write File";
      }
      {
        key = "<c-h>";
        mode = "n";
        action = "<c-w>h";
        desc = "Go to the left window";
      }
      {
        key = "<c-s-h>";
        mode = "n";
        action = "<c-w>H";
        desc = "Go to the far left window";
      }
      {
        key = "<c-l>";
        mode = "n";
        action = "<c-w>l";
        desc = "Go to the right window";
      }
      {
        key = "<c-s-l>";
        mode = "n";
        action = "<c-w>L";
        desc = "Go to the far right window";
      }
      {
        key = "<c-k>";
        mode = "n";
        action = "<c-w>k";
        desc = "Go to the up window";
      }
      {
        key = "<c-s-k>";
        mode = "n";
        action = "<c-w>K";
        desc = "Go to the far up window";
      }
      {
        key = "<c-j>";
        mode = "n";
        action = "<c-w>j";
        desc = "Go to the down window";
      }
      {
        key = "<c-s-j>";
        mode = "n";
        action = "<c-w>J";
        desc = "Go to the far down window";
      }
      {
        key = "<leader>uC";
        mode = "n";
        action = "function() Snacks.picker.colorschemes() end";
        desc = "Colorschemes";
        lua = true;
      }
      {
        key = "<leader>sk";
        mode = "n";
        action = "function() Snacks.picker.keymaps() end";
        desc = "Search Keymaps";
        lua = true;
      }
      {
        key = "<leader>fg";
        mode = "n";
        action = "function() Snacks.picker.git_files() end";
        desc = "Find Git Files";
        lua = true;
      }
      {
        key = "<leader>cf";
        action = ''function() require("conform").format() end'';
        mode = [
          "n"
          "x"
        ];
        desc = "Format Code";
        lua = true;
      }
      {
        key = "<leader>cF";
        action = ''function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end'';
        mode = [
          "n"
          "x"
        ];
        desc = "Format Injected Langs";
        lua = true;
      }
    ];

    clipboard.enable = true;
    clipboard.registers = "unnamedplus";
  };
}
