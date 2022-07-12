# Computer specific file for Ryzen
# Odyssey346 2022
{ config, pkgs, ...}:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "Ryzen"; # Define your hostname.

  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];	
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.logitech.wireless = { # MX Master 3
      enable = true;
      enableGraphical = true;
    };
}
