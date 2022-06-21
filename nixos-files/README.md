# WiFi testbed
The following describes how to configure a WiFi testbed to reproduce the experiments contained in my thesis.

You will need:

- A WiFi access point
- 5 Raspberry Pi 4 machines (4 GB RAM will do, haven't tested with 2 GB but that may be fine as well)
- Memory cards for the Raspberry Pis (I've used 32GB HC1 class 10)
- A memory card reader/writer
- An Alfa AWUS036ACH WiFi adapter
- A micro-HDMI cable
- A keyboard + mouse
- A monitor

The setup process is as follows:

First, build a NixOS image for the raspberry pi. Unless you have an aarch64-compatible machine readily available, this step takes some bootstrapping.
We can use one of the Raspberry Pis as an aarch64 builder, but first we need to get NixOS running on it.
Luckily, NixOS images for Raspberry Pi are availble online. Download the generic image linked here and follow instruction to write it to an SD card: https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi
Insert the SD card and boot up. Connect the RPi to a keyboard/mouse/monitor and configure it so you can get SSH access from your laptop.

Once one of the Raspberry Pis is running NixOS and you have SSH access, we can configure it to be a build server for NixOps. The benefits of building images ourselves is that we can pre-load the images with information about which WiFi network we want it to connect to and which SSH keys we want to give access to.

A guide on how to configure remote builders can be found here (also see the comments in sd-image.nix): https://nixos.wiki/wiki/Distributed_build

Add your SSH keys to sd-image.nix, and configure your WiFi network in wifi_connection.nix. Then build the new image with nixos-generate -f sd-aarch64-installer --system aarch64-linux -c sd-image.nix

Once the image is built, flash it to each of the SD cards and plug them in. You should see the machines connect to the WiFi automatically once they boot up.
Find the IPs of each machine and use these to configure the default.nix file. Notice that some machines in default.nix are configured without a WiFi link, make sure these are connected to the AP over Ethernet.

We can now use NixOps to configure all of the machines at once.
Run:
nixops create default.nix
nixops list
nixops deploy
nixops info

I once found that the build failed when using the default release for nixos. The solution was to try another release.
This command can be used to configure a specific nixos release:
export NIX_PATH=nixpkgs=https://releases.nixos.org/nixos/21.11/nixos-21.11.336020.2128d0aa28e/nixexprs.tar.xz
