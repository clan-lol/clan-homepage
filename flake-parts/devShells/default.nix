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
        shellHook = ''
          ln -snf "$PWD"/static "$PWD"/website/static
        '';
      };
    };
}
