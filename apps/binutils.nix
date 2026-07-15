{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.binutils ];
}
