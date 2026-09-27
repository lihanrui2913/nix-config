{ pkgs, ... }:

{
  imports = [ ../apps ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [
    "127.0.0.1"
    "::1"
  ];
  networking.firewall.enable = false;

  time.timeZone = "Asia/Shanghai";

  services.blocky = {
    enable = true;
    settings = {
      port = 53;
      upstream = {
        default = [
          "https://doh.pub/dns-query"
        ];
      };
      bootstrapDns = {
        upstream = "8.8.8.8:53";
        ips = [
          "1.12.12.12"
          "120.53.53.53"
        ];
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
        prefetchExpires = "2h";
      };
    };
  };
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.blueman.enable = true;
  services.libinput.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.openssh.enable = true;
  system.stateVersion = "26.05";
}
