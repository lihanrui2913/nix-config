{
  imports = [ ./apps ];

  home.username = "void";
  home.homeDirectory = "/home/void";
  home.stateVersion = "26.05";

  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;
}
