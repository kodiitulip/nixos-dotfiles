{ pkgs, lib, ... }:

{
  imports = [
  ];

  vim.mini = {
    ai.enable = true;
    animate.enable = true;
    colors.enable = true;
    comment.enable = true;
    hipatterns.enable = true;
    icons.enable = true;
    snippets.enable = true;
    surround.enable = true;

  };

}
