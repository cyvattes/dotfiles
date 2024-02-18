{ config, pkgs, ... }:

{
  users = {
    users.ket = {
      isNormalUser = true;
      description = "CK Vattes";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
