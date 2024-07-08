{
  description = "Website of the clan project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ lib, ... }: {
      systems = [ "x86_64-linux" ];
      imports = [
        ./flake-parts/deploy.nix
        ./flake-parts/devShells
        ./flake-parts/website.nix
      ];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.writeShellScriptBin "true" "true";
      };
    });
}
