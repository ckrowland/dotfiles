{
  description = "My NixOS config flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-25-05.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-25-05,
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
      pkgs-25-05 = nixpkgs-25-05.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        macbook = lib.nixosSystem {
          inherit system;
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./configuration.nix
          ];
          specialArgs = {
            inherit pkgs-25-05;
          };
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
