with import <nixpkgs> {};
mkShell {
  packages = [
    bashInteractive
    zola
  ];
}
