{ pkgs, ... }:
{
  services.asusd.enable = true;
  environment.systemPackages = [ pkgs.asusctl ];
}
