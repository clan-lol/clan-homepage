{
  perSystem =
    { inputs'
    , lib
    , pkgs
    , self'
    , ...
    }: {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.bashInteractive
          pkgs.zola
        ];
        inputsFrom = [
          inputs'.clan-core.devShells.default
        ];
      };
    };
}
