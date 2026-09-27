{ inputs, ... }:

{
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  services.displayManager.noctalia-greeter = {
    enable = true;

    settings = {
      session.default = "Umbriel";

      keyboard.layout = "us";
    };
  };
}
