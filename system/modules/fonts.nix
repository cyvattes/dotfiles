{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
      nerdfonts
    ];
  };
}
