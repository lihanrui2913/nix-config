{ config, pkgs, ... }:

let
  myPython = pkgs.python314.withPackages (
    ps: with ps; [
      torchWithRocm
    ]
  );
in
{
  environment.systemPackages = [ myPython ];
}
