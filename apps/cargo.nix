{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.cargo ];
}
