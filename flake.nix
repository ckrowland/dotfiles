{
  description = "My NixOS config flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-flatpak,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        macbook = lib.nixosSystem {
          inherit system;
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        connor = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          libxkbcommon
          vulkan-loader
          vulkan-validation-layers
          vulkan-tools
          xorg.libX11
          zig
        ];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
          with pkgs;
          [
            wayland
          ]
        );
      };
    };

}
