{
  network = {
    storage.legacy = {};
    description = "WiFi testbed";
  };

  defaults = {
    imports = [ ./common.nix ];
  };
  
  server =
    { config, pkgs, ... }:
    {
      networking.hostName = "server";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.176";
      imports = [./hardware-configuration.nix
                 ./chrony_server.nix];
      boot.extraModulePackages = with config.boot.kernelPackages; [
          rtl8812au
        ];
      boot.initrd.kernelModules = [ "8812au" ];
        
      networking.wireless = {
        enable = true;
        interfaces = ["wlan0"];
        };

      networking.networkmanager.enable = true;
      users.users.domos.extraGroups = ["networkmanager"];
      networking.networkmanager.unmanaged = ["wlan0"];
    };

  client =
    { config, pkgs, ... }:
    {
      networking.hostName = "client";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.139";
      imports = [./hardware-configuration.nix
                 ./chrony_client.nix
                 ./wifi_connection.nix];
    };

  traffic-1 =
    { config, pkgs, ... }:
    {
      networking.hostName = "traffic-1";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.100";
      imports = [./hardware-configuration.nix
                 ./chrony_client.nix
                 ./wifi_connection.nix];
    };

  traffic-2 =
    { config, pkgs, ... }:
    {
      networking.hostName = "traffic-2";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.102";
      imports = [./hardware-configuration.nix
                 ./chrony_client.nix
                 ./wifi_connection.nix];
    };

  traffic-3 =
    { config, pkgs, ... }:
    {
      networking.hostName = "traffic-3";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.109";
      imports = [./hardware-configuration.nix
                 ./chrony_client.nix
                 ./wifi_connection.nix];
    };

  traffic-4 =
    { config, pkgs, ... }:
    {
      networking.hostName = "traffic-4";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.112";
      imports = [./hardware-configuration.nix
                 ./chrony_client.nix
                 ./wifi_connection.nix];
    };
  
  traffic-5 =
    { config, pkgs, ... }:
    {
      networking.hostName = "traffic-5";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.121";  
      imports = [./hardware-configuration.nix
                 ./chrony_client.nix
                 ./wifi_connection.nix];
    };

  domos-1 =
    { config, pkgs, ... }:
    {
      networking.hostName = "domos-1";
      nixpkgs.system = "aarch64-linux";
      deployment.targetHost = "192.168.3.129";
      imports = [./hardware-configuration.nix
                 ./chrony_client.nix];
      ## Enable TCP modules
      boot.kernelModules = [ "tcp_bbr"
                             "tcp_cubic"
                             "tcp_highspeed"
                             "tcp_hybla"
                             "tcp_illinois"
                             "tcp_nv"
                             "tcp_scalable"
                             "tcp_westwood"
                             "tcp_yeah"];
      boot.kernel.sysctl = {
        #"net.ipv4.tcp_congestion_control" = "bbr";
        #"net.core.default_qdisc" = "cake";
      };
    };
}