{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.cargo
    pkgs.clippy
    pkgs.rustc
    pkgs.rustfmt
    pkgs.rust-analyzer
  ];
}
