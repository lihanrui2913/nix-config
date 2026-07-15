{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rust-analyzer ];
}
