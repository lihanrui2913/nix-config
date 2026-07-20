{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.openjdk8
    pkgs.openjdk17
    pkgs.openjdk21
    pkgs.openjdk25
  ];
}
