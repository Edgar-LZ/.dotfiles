# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #NIXOS
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  #OPENGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Bootloader.
  boot = {
	loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
		};

  #Boot kernel modules for controllers
		kernelModules = [ "i2c-dev" "xpad" "hid-nintendo" "xone" "xpadneo" ];
		extraModulePackages = [
			config.boot.kernelPackages.ddcci-driver
			config.boot.kernelPackages.xone
			config.boot.kernelPackages.xpadneo
		(config.boot.kernelPackages.callPackage ./xpad.nix {})
		];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  # 8bitdoController xpad
  services = {
  	udev.extraRules = ''
ACTION=="add", \
	ATTRS{idVendor}=="2dc8", \
	ATTRS{idProduct}=="3106", \
	RUN+="${pkgs.kmod}/bin/modprobe xpad", \
	RUN+="${pkgs.bash}/bin/sh -c 'echo 2dc8 3106 > /sys/bus/usb/drivers/xpad/new_id'"
'';
  };

  # Flatpak
  services.flatpak.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;

  # Enable the XFCE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # Enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.input.General.ClassicalBondedOnly = false;
  services.blueman.enable = true;

  # USB services
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };

  #NVIDIA
  services.xserver.videoDrivers = ["nvidia"];
 
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from diver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommened setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {

      #provides $nvidia-offload <command>
      #the command runs in gpu
      #offload = {
      #  enable = true;
      #  enableOffloadCmd = true;
      #};

      sync.enable = true;

      # integrated
      intelBusId = "PCI:0:2:0";
      #amdgpubusID = "PCI:0:0:0";

      #dedicated
      nvidiaBusId = "PCI:01:0:0";
    };

  }; 

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "latam";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

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
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.inx01 = {
    isNormalUser = true;
    description = "inx01";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hyprland

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Thunar
  programs.thunar.enable = true;

  # Backlight
  programs.light.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  # Install Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  programs.gamemode.enable = true;

  hardware.steam-hardware.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/user/.steam/root/compatibilitytools.d";
    # If cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
  # protonup
  # gamemoderun <command>
  # mangohud <command>
  # gamescope <command>

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
    lf
    mangohud
    protonup
    home-manager
    waybar
    (waybar.overrideAttrs (oldAttrs : {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    dunst
    libnotify
    swww
    kitty
    rofi-wayland
    ntfs3g # Might need exfat-util or something similar to work correctly
  ];

  # Desktop portal handle desktop progams interactions with each other, screen sharing, file opening etc
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Fonts

  fonts.packages = with pkgs; [

    noto-fonts

    noto-fonts-cjk

    noto-fonts-emoji

    liberation_ttf

    fira-code

    fira-code-symbols

    (nerdfonts.override {fonts = [ "FiraCode"  "DroidSansMono"  ];})

  ]; 

  fonts.fontconfig = {
	defaultFonts = {
		emoji = ["noto-fonts-emoji"];
	};
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
