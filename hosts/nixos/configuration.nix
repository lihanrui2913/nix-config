{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
  ];

  networking.hostName = "nixos";
  networking.nameservers = [
    "223.5.5.5"
    "223.6.6.6"
    "8.8.8.8"
  ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/ssh"
      "/etc/NetworkManager/system-connections"
      "/var/lib/NetworkManager"
      "/var/lib/bluetooth"
      "/var/lib/colord"
      "/var/lib/cups"
      "/var/lib/nixos"
      "/var/lib/pipewire"
      "/var/lib/systemd"
      "/var/lib/upower"
      "/var/log"
    ];
    files = [ "/etc/machine-id" ];
  };

  users.users.void = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$y$j9T$2QGvIogDUhh8zAuVGtnXV0$irsC2MM77JO8jr6yg.CvkbaCTdEBwSsv8nrBd8jCT87";
    shell = pkgs.zsh;
  };
}
