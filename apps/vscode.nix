{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-ceintl.vscode-language-pack-zh-hant
      pkief.material-icon-theme
      bbenoist.nix
      ms-vscode.cpptools
      rust-lang.rust-analyzer
    ];
  };
}
