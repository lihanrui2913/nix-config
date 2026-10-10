{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.python314 ];
}
