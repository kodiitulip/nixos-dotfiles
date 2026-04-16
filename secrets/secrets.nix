let
  kodie = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIlsbUta5cO8PicTkHK/QsGstrJkF0m3mtQbiVwbHWRy";
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5gmq70r9IzcBbS5p9GFQwFAvAhTAeWBkPrLklNPsen";
in
{
  "playitgg.age".publicKeys = [
    kodie
    nixos
  ];
}
