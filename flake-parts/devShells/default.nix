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
          
        ];
      };
    };
}
