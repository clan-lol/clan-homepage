{
  description = "Website of the clan project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    clan-core.url = "git+https://git.clan.lol/clan/clan-core";
    clan-core.inputs.flake-parts.follows = "flake-parts";
    clan-core.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, flake-parts, clan-core, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ lib, ... }: {
      systems = [ "x86_64-linux" ];
      imports = [
        ./flake-parts/deploy.nix
        ./flake-parts/devShells
        ./flake-parts/new-post.nix
        ./flake-parts/website.nix
      ];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.writeShellScriptBin "true" "true";
      };
    });
}
