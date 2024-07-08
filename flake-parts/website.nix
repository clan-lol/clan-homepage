{ self, ... }:
{
  perSystem =
    {
      lib,
      pkgs,
      self',
      inputs',
      ...
    }:
    let
      build =
        baseUrl:
        pkgs.runCommand "website" { buildInputs = [ ]; } ''
          mkdir -p $out
          cp -r ${self}/* .
          chmod -R u+w .

          cp -r website/* website/.* $out
          rm $out/static
          cp -r static/ $out/static
        '';
    in
    {
      packages.default = self'.packages.website;
      packages.website = build "https://clan.lol";
      packages.website-localhost = build "http://localhost:1111";
      packages.serve = pkgs.writeShellScriptBin "serve-local" ''
        echo "serving: ${self'.packages.website-localhost}"
        ${pkgs.python3}/bin/python -m http.server 1111 \
          -d website
      '';
    };
}
