{ config, pkgs, ...}:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  

  boot.supportedFilesystems = [ "ntfs" ]; # Support NTFS because I have NTFS drives on this computer.
  networking.hostName = "Ryzen"; # Define your hostname.

  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];	
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  
  # 32 bit OpenGL support
  hardware.opengl.driSupport32Bit = true;

  hardware.logitech.wireless = { # MX Master 3
      enable = true;
      enableGraphical = true;
  };

  environment.systemPackages = with pkgs; [
        logiops
  ];
  
  environment.etc."logid.cfg".source = /etc/nixos/extras/logid.cfg;
}
