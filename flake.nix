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

    flake-utils.url = "github:numtide/flake-utils";

  };
  outputs = { self, nixpkgs, neovim, flake-utils, }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = neovim.packages.${system}.neovim;
        };

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

        buildNodeJs = pkgs.callPackage "${nixpkgs}/pkgs/development/web/nodejs/nodejs.nix" {
            python = pkgs.python3;
        };

        nodejs = buildNodeJs {
            enableNpm = true;
            version = "20.5.1";
            sha256 = "sha256-Q5xxqi84woYWV7+lOOmRkaVxJYBmy/1FSFhgScgTQZA=";
        };

      in
      {
        flakedPkgs = pkgs;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            openssl
            pkg-config
            customNeovim
            nodejs
          ];
        };

        devShell = pkgs.mkShell{
            buildinputs = with pkgs; [
                nodejs
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

