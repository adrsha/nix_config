{
  # Description of the flake and its purpose
  description = "NixOS System Configuration Flake";

  # Input sources for the flake
  inputs = {
    # nixpkgs: Main source for Nix packages
    # Using nixos-unstable for latest stable packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # home-manager: User environment management
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # Use the same nixpkgs as the system
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # PrismLauncher input
    # Note: Consider if you really need the cracked version
    # as it might have security implications
    prism.url = "github:Diegiwg/PrismLauncher-Cracked/develop";
  };

  # Function that produces the flake's outputs
  outputs = { 
    self,
    nixpkgs,
    home-manager,
    ...  # Using ... to capture all inputs
  } @ inputs: let
    
    # System architecture definition
    system = "x86_64-linux";

    # Initialize the package set for the given system
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # NixOS system configurations
    # This defines how to build your entire NixOS system
    nixosConfigurations = {
      # "nixos" is the hostname - you might want to change this
      # to something more specific to your system
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        
        # Pass all inputs to make them available in configuration.nix
        specialArgs = { inherit inputs; };
        
        # List of configuration modules
        modules = [
          ./configuration.nix
        ];
      };
    };

    # Home-manager configurations for user environments
    homeConfigurations = {
      # "chilly" is the username - adjust this to match your username
      chilly = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        
        # Make inputs available in each of the modules
        extraSpecialArgs = { inherit inputs; };
        
        # User-specific configuration modules
        modules = [ 
          ./home.nix
          modules/hyprland.nix
          modules/alacritty.nix
        ];
      };
    };

# You might want to add additional outputs here, such as:
# packages.${system} = { ... };
# devShells.${system} = { ... };
  };
}
