{ config, pkgs, ... }:

{
  networking.hostName = "blackram";
  networking.networkmanager.enable = true;
}
