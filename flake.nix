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

            # force = {
            #     url = "github:jutskitting/sfdx-shortcut-flake";
            # };

            force.url = "path:/home/kit/Documents/flakes/sfdx-shortcut-flake";

            flake-utils.url = "github:numtide/flake-utils";

        };
    outputs = { self, nixpkgs, neovim, flake-utils,force, }:
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
                    inherit system;
                    inherit overlays;
                };

                # sf = with pkgs; buildNpmPackage rec {
                #   pname = "sf";
                #   version = "2.27.4";
                #
                #   src = fetchFromGitHub {
                #     owner = "salesforcecli";
                #     repo = pname;
                #     rev = "v${version}";
                #     hash = "sha256-BgkDmswsA9uns7IlUhfFvrm7hDHomOlK+yrdI4abT6I=";
                #   };
                #
                #   npmDepsHash = "sha256-m4DTkMBxZF8j+XyRd7IadgIE9W716j7oXrUG+rE5cn4=";
                #
                #   # The prepack script runs the build script, which we'd rather do in the build phase.
                #   npmPackFlags = [ "--ignore-scripts" ];
                #   #
                #   postPatch=''
                #         ls
                #         install -D ${./package-lock.json} ./package-lock.json
                #   '';
                #   NODE_OPTIONS = "--openssl-legacy-provider";
                # };

            in
            {

                devShells.default = with pkgs; mkShell {
                    buildInputs = [
                       nodejs_21
                       openssl
                       pkg-config
                       customNeovim
                       force.defaultPackage.${system}
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

