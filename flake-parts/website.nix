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

          substituteInPlace config.toml --replace \
            'base_url = "https://clan.lol"' \
            'base_url = "${baseUrl}"' \

          cp -r website/* website/.* $out
          cp -r static/* static/.* $out
        '';
    in
    {
      packages.default = self'.packages.website;
      packages.website = build "https://clan.lol";
      packages.website-localhost = build "http://localhost:1111";
      packages.serve = pkgs.writeShellScriptBin "serve-local" ''
        echo "serving: ${self'.packages.website-localhost}"
        ${pkgs.python3}/bin/python -m http.server 1111 \
          -d ${self'.packages.website-localhost}
      '';
    };
}
