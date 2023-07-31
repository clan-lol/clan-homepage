{
  description = "Website of the clan project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    clan-core.url = "git+https://git.clan.lol/clan/clan-core";
    clan-core.inputs.flake-parts.follows = "flake-parts";
    clan-core.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ lib, ... }: {
      systems = lib.systems.flakeExposed;
      imports = [
        ./flake-parts/deploy.nix
        ./flake-parts/devShells
      ];
      perSystem = { pkgs, ... }: {
        packages.default = pkgs.runCommand "website" {
          buildInputs = [ pkgs.zola ];
        } ''
          mkdir -p $out
          cp -r ${self}/* .
          chmod -R u+w .
          zola build
          cp -r public/* public/.* $out
        '';
      };
    });
}
