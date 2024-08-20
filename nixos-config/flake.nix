{
  description = "vic's nixos configuration";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, lanzaboote, ... }@inputs: {
    nixosConfigurations.nosesisaid = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { 

        pkgs-stable = import nixpkgs { 
          inherit system;
          config = { allowUnfree = true; };
        };
        pkgs-unstable = import nixpkgs-unstable { 
          inherit system;
          config = { allowUnfree = true; };
        };


        inherit inputs;

        };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
	./nosesisaid/dedicated.nix
       # ./nosesisaid/secureboot.nix
      home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.vic = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            home-manager.extraSpecialArgs = { 
              pkgs-unstable = import nixpkgs-unstable { 
                  #inherit system;
                  system = "x86_64-linux";
                  config = { allowUnfree = true; };
                };
                inherit inputs;
            };
          }
      ];
  };
  nixosConfigurations.alum = nixpkgs.lib.nixosSystem rec {
	system = "x86_64-linux";
	specialArgs = {
	pkgs-stable = import nixpkgs { 
          inherit system;
          config = { allowUnfree = true; };
        };
        pkgs-unstable = import nixpkgs-unstable { 
          inherit system;
          config = { allowUnfree = true; };
        };

        inherit inputs;

        };
	modules = [

	./configuration.nix
	./alum/dedicated.nix
	 home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.vic = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            home-manager.extraSpecialArgs = { 
              pkgs-unstable = import nixpkgs-unstable { 
                  #inherit system;
                  system = "x86_64-linux";
                  config = { allowUnfree = true; };
		          };
              inherit inputs;
            };
          }

	          ];
	      };
    };
}
