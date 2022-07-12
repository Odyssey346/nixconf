# Computer specific settings for Jambi
# Odyssey346 2022
{ config, pkgs, ...}:

{
    # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "Jambi"; # Define your hostname.
}
