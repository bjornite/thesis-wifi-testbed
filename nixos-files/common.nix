{ config, pkgs, ... }:

{
  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_rpi4;
  boot.loader.raspberryPi = {
    enable = true;
    version = 4;
  };
  console = {
     font = "Lat2-Terminus16";
     keyMap = "no";
  };
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;
  # Enable the OpenSSH daemon.
  services.openssh = {
   enable = true;
   permitRootLogin = "yes";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    # Add the public ssh keys you want to give access to here. Example:
    #"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLoRiFchJRetN79N9aKyHnkYSJRoMdUgXoz0oo1yVabLvDjwUUeXLr+ch6ySrE9e4A1+E3pVHpidbHdP0NcBEXi6sSz2FBPw8hBOVkpwZ5/cwKHLRIBcIPDumpp7P0ZfqUnyXrPR0L4aZBHobPZ0LG7iEU8WMDj4TX13ZKexDFESe2MHejMOh1iBWXgc/Y04ptlSnuNtitY9zZdO95EMKGx+et4NiVia+5KZvIgT7/xZfEiE4Skhqrohb9FnmLW+kr4J+O7LRKENKT+tpULqsGnm+zREQVhIqoCyjJESbX8S57N0UdtshCrWGm1RvGCv+RRE9XNi3Ahd9xtYUK4b7R bjorn@bjorn-ThinkPad-E14"
    ];
   environment.systemPackages = with pkgs; [
    git
    vim
    gcc
    gnumake
    chrony
    python3
    iperf3
    wireshark
    flent
    netperf
   ];
   networking.firewall.enable = false;
   
   
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.03"; # Did you read the comment?
}
