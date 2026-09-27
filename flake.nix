{
  description = "Void's reproducible NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/8eeec934ae0dbeca3d7868c059568a65c08b2fc3";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umbriel.url = "github:noctalia-dev/umbriel";

    noctalia.url = "github:noctalia-dev/noctalia";

    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    deepseek-harness.url = "github:moraxyc/deepseek-harness.nix";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      impermanence,
      nix-cachyos-kernel,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
              ];
            }
          )
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.void = import ./home/void/void.nix;
          }
        ];
      };
    };
}
