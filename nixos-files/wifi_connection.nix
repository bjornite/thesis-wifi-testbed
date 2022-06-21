{ config, pkgs, ... }:

{ 
  networking.wireless = {
  enable = true;
  interfaces = ["wlan0"];
  networks = { # Configure the WiFi you want machines to connect to automatically. Documentation: https://nixos.org/manual/nixos/stable/#sec-wireless
    iopsys-622D = {};
   };
  };
}
