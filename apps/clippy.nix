{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.clippy ];
}
