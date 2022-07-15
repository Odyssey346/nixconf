# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
     # Home Manager
     <home-manager/nixos>
     # Computer Specific Settings
      ./computer-specific.nix
    ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  #networking.wireless.iwd.enable = true;
  #networking.networkmanager.wifi.backend = "iwd";
  # Set your time zone.
  time.timeZone = "Europe/Oslo";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.utf8";
    LC_IDENTIFICATION = "nb_NO.utf8";
    LC_MEASUREMENT = "nb_NO.utf8";
    LC_MONETARY = "nb_NO.utf8";
    LC_NAME = "nb_NO.utf8";
    LC_NUMERIC = "nb_NO.utf8";
    LC_PAPER = "nb_NO.utf8";
    LC_TELEPHONE = "nb_NO.utf8";
    LC_TIME = "nb_NO.utf8";
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "nb_NO.UTF-8/UTF-8"
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "no";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
      users = [ "user" ];
      keepEnv = true;
      persist = true;
  }];

  home-manager.users.user = { pkgs, ...	}: {
	home.packages = [
		pkgs.firefox 
		pkgs.kate 
		pkgs.thunderbird 
		pkgs.nheko 
		pkgs.vscode 
		pkgs.discord-canary 
		pkgs.syncthing 
		pkgs.termius 
                pkgs.tor-browser-bundle-bin
                pkgs.ark
                pkgs.discover
                pkgs.kde-gtk-config
                pkgs.polymc
                pkgs.steam
                pkgs.gnome.cheese
                pkgs.libsForQt5.breeze-gtk
                pkgs.spicetify-cli
                pkgs.lightly-qt
                pkgs.googleearth-pro
                pkgs.simplescreenrecorder
                pkgs.kdenlive
                pkgs.vlc
                pkgs.keepassxc
                pkgs.asciinema
                pkgs.minetest
	];
	programs.bash = {
		enable = true;
		shellAliases = {
			"nors" = "doas nixos-rebuild switch -j 8";
			"open-config" = "doas vim /etc/nixos/";
                  "pubip" = "curl checkip.amazonaws.com";
                  "download" = "curl -LJO";
                  "spicetify" = "spicetify-cli";
		};
	};
	home.stateVersion = "22.11";
	nixpkgs.config = import /etc/nixos/extras/nixpkgs.nix;
	programs.git = {
		enable = true;
		userName = "Odyssey346";
		userEmail = "odyssey346@disroot.org";
	};
	programs.vim = {
		enable = true;
		plugins = with pkgs.vimPlugins; [
			vim-airline
		];
		settings = {
			number = true;
		};
        };
        programs.firefox = {
                  enable = true;
        };
        home.pointerCursor = {
                  x11.enable = true;
                  package = pkgs.libsForQt5.breeze-icons;
                  name = "Breeze";
                  size = 24;
       };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    neofetch # Gotta have Neofetch
    git
    unzip
    libsForQt5.sddm-kcm
    mullvad-vpn
    python39Full
    python39Packages.pip
    htop
  ];
  
  fonts.fonts = with pkgs; [
      noto-fonts-cjk
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  
  programs.gamemode.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  security.pam.services.sddm.enableKwallet = true;
  # The garbage collector man does not get paid for this.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Enable flatpak (bloat)
  services.flatpak.enable = true;
  
  # Mullvad best vpn 2022 privacy antimalware
  services.mullvad-vpn.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
