{
  description = "nixos configuration";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, home-manager-unstable, lix-module, ... }@inputs: {
    nixosConfigurations.framework1 = nixpkgs-unstable.lib.nixosSystem rec {
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
	      ./framework1/dedicated.nix
      home-manager-unstable.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.vic = import ./framework1/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            home-manager.extraSpecialArgs = { 
              pkgs-unstable = import nixpkgs-unstable { 
                  #inherit system;
                  system = "x86_64-linux";
                  config = { allowUnfree = true; };
              };

              pkgs-stable = import nixpkgs {
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
