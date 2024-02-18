{ config, pkgs, lib, ... }:

{
  environment = {
    sessionVariables = rec {
      XCURSOR_SIZE = "24";
    };

    systemPackages = with pkgs; [
      alacritty
      brightnessctl
      dunst
      fuzzel
      libnotify
      networkmanagerapplet
      sway
      waybar
      wayland
      wl-clipboard
    ];
  };

  hardware = {
    opengl.enable = true;
  };

  programs = {
    sway.enable = true;
    waybar.enable = true;
  };

  # Display Manager
  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "ket";
      };
    };
  };

  xdg = {
    portal.enable = true;
    portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
