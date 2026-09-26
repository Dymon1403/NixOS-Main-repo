{ config, pkgs, ... }:

{
  # ============================================
  # Boot
  # ============================================
  # maybe all go fine
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   # Mount point
  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  }

  fileSystems."/" = {
    device = "/dev/nvme0n1p2";
    fsType = "ext4";
  };

}



  # ============================================
  # Network
  # ============================================

  networking.hostName = "thinkpad";

  networking.networkmanager.enable = true;


  # ============================================
  # Locale / Time
  # ============================================

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";


  i18n.extraLocaleSettings = {
    LC_TIME = "ru_RU.UTF-8";
  
  };


  # ============================================
  # Keyboard
  # ============================================

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:caps_toggle,caps:shift_capslock";
  };


  # ============================================
  # User
  # ============================================

  users.users.dmitrj = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "docker"
  ];

    shell = pkgs.bash;
  };


  # ============================================
  # Firmware
  # ============================================

  hardware.enableRedistributableFirmware = true;


  # ============================================
  # Graphics
  # ============================================

  hardware.graphics.enable = true;


  # ============================================
  # Login manager
  # ============================================

  services.displayManager.ly.enable = true;


  # ============================================
  # Hyprland
  # ============================================

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


  # ============================================
  # XDG portals
  # ============================================

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };


  # ============================================
  # Sound
  # ============================================

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
  };

  security.rtkit.enable = true;


  # ============================================
  # Packages
  # ============================================

  environment.systemPackages = with pkgs; [

    # --------------------------------------------
    # System
    # --------------------------------------------

    git
    neovim

    wget
    curl

    htop
    fastfetch


    # --------------------------------------------
    # Terminal, alactirry best terminal ever lollll
    # --------------------------------------------

    alacritty


    # --------------------------------------------
    # Desktop
    # --------------------------------------------
    
    waybar

    # --------------------------------------------
    # Hyprland utilities
    # --------------------------------------------

    grim
    slurp
    wl-clipboard

    brightnessctl


    # --------------------------------------------
    # Wallpaper
    # --------------------------------------------

    waypaper
    swww


    # --------------------------------------------
    # Audio
    # --------------------------------------------

    pulsemixer

    mpd
    mpc
    mpd-mpris


    # --------------------------------------------
    # Applications
    # --------------------------------------------

    firefox

    # --------------------------------------------
    # Fonts
    # --------------------------------------------

    nerd-fonts.jetbrains-mono
  ];


  # ============================================
  # Fonts
  # ============================================

  fonts.fontconfig.enable = true;


  # ============================================
  # Nix
  # ============================================

  nix.settings.auto-optimise-store = true;


  # ============================================
  # NixOS version
  # ============================================

  system.stateVersion = "26.05";
}
