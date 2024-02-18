{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;

  services = {
    blueman.enable = true;
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
