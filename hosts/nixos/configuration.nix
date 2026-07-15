{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
  ];

  networking.hostName = "nixos";

  users.users.void = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$y$j9T$2QGvIogDUhh8zAuVGtnXV0$irsC2MM77JO8jr6yg.CvkbaCTdEBwSsv8nrBd8jCT87";
    shell = pkgs.zsh;
  };
}
