{
    description = "A Neovim Shell for salesforce development";

    inputs = {

      nixpkgs = {
           url = "github:NixOS/nixpkgs/nixos-unstable";
      };

      neovim = {
          url = "github:neovim/neovim/stable?dir=contrib";
          inputs.nixpkgs.follows = "nixpkgs";
      };

      force = {
          url = "github:jutskitting/sfdx-shortcut-flake";
      };

      flake-utils.url = "github:numtide/flake-utils";

  };
  outputs = { self, nixpkgs, neovim, flake-utils,force, }:
    flake-utils.lib.eachDefaultSystem (system:
        let

            overlayFlakeInputs = prev: final: {
              neovim = neovim.packages.${system}.neovim;
            };

            # force-import = force.packages.${system}.default;

            overlayNeovim = prev: final: {
              customNeovim = import ./packages/nvimConfig.nix {
                pkgs = final;
              };
            };

            overlays = [ 
                overlayFlakeInputs
                overlayNeovim
            ];

            pkgs = import nixpkgs {
              inherit system overlays;
            };

        in
        {

            devShells.default = pkgs.mkShell {
                buildInputs = with pkgs; [
                   openssl
                   pkg-config
                   customNeovim
                   nodejs
                   # force-import
                ];
            };

            packages.default = pkgs.customNeovim;

            apps.default = {
                  type = "app";
                  program = "${pkgs.customNeovim}/bin/nvim";
            };
        }
    );
}

