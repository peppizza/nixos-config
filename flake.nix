{
  description = "Nixos config flake";

  inputs = {
    # Official package repositories
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Main flakes
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      stylix,
      ...
    }:
    {
      nixosConfigurations =
        let
          system = "x86_64-linux";

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ (self: super: { illuminanced = super.callPackage ./pkgs/illuminanced { }; }) ];
          };
        in
        {
          nixos-desktop = nixpkgs.lib.nixosSystem rec {
            inherit system;

            specialArgs = {
              inherit inputs pkgs;
            };

            modules = [
              ./hosts/desktop/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.spencer = {
                    imports = [ ./hosts/desktop/home.nix ];
                  };
                  extraSpecialArgs = specialArgs;
                  backupFileExtension = "bak";
                };
              }
              stylix.nixosModules.stylix
            ];
          };

          nixos-laptop = nixpkgs.lib.nixosSystem rec {
            inherit system;

            specialArgs = {
              inherit inputs pkgs;
            };

            modules = [
              ./hosts/laptop/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.spencer = {
                    imports = [ ./hosts/laptop/home.nix ];
                  };
                  extraSpecialArgs = specialArgs;
                  backupFileExtension = "bak";
                };
              }
              nixos-hardware.nixosModules.framework-16-7040-amd
              stylix.nixosModules.stylix
            ];
          };
        };
    };
}
