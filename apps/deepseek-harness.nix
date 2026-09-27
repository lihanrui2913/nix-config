{ inputs, pkgs, ... }:
{
  imports = [ inputs.deepseek-harness.nixosModules.default ];
  programs.dsh = {
    enable = true;
    profiles.tui = {
      bundles = [ pkgs.dsh.bundles.tui ];
      mode = "managed";
      patch = [
        {
          target = "@deepseek-ai/dsh-terminal-bash";
          set = {
            shellPath = "${pkgs.bash}/bin/bash";
          };
        }
      ];
    };
  };
}
