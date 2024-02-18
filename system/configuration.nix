{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix	# Hardware Optimization
    ./modules/audio.nix			# Audio
    ./modules/fonts.nix			# Fonts
    ./modules/localization.nix		# Language/Localization
    ./modules/networking.nix		# Network Settings
    ./modules/sway.nix			# Wayland DM/WM
    ./modules/users.nix			# User Policy Settings
    ./modules/zsh.nix			# Terminal
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System Settings
  system.stateVersion = "23.11";
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  # Environment
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # System
    curl
    unzip
    vim
    wget

    # User
    firefox
  ];
}
