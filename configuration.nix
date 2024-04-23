{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/framework/13-inch/12th-gen-intel>  # Framework Fixes
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System
  system.stateVersion = "23.11"; # Did you read the comment?
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Networking
  networking.hostName = "blackram";
  networking.networkmanager.enable = true;

  # Users
  users.defaultUserShell = pkgs.zsh;
  users.users.ket = {
    isNormalUser = true;
    description = "CK Vattes";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #firefox
      git
      gnome.gnome-tweaks
      google-chrome
    ];
  };

  # Localization
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Fonts
  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [

    ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Environment Settings
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    curl
    unzip
    vim
    wget
    zsh
  ];

  # Enabled Programs
  programs.zsh.enable = true;
  programs.steam.enable = true;
  #services.flatpak.enable = true;
}
