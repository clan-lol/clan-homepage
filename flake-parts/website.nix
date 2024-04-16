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
        pkgs.runCommand "website" { buildInputs = [ pkgs.zola ]; } ''
          mkdir -p $out
          cp -r ${self}/* .
          chmod -R u+w .

          substituteInPlace config.toml --replace \
            'base_url = "https://clan.lol"' \
            'base_url = "${baseUrl}"' \

          # generates a zola compatible .md from a clan-core/docs/**/*.md
          generatePage() {
            local sourceFile="$1"
            local targetFile="$2"

            # generate title by reading first non-empty line of $file and stripping all '#' symbols
            title=$(sed -n '/./{p;q}' "$sourceFile" | sed 's/#*//g')
            echo "generating page from clan-core: $title"

            # generate header with title, template, weight to make zola happy
            echo -e "+++\ntitle = \"$title\"\ntemplate = \"docs/page.html\"\nweight = 0\n+++" > "$targetFile"

            # append everything from the file but remove header line starting with '#' and all preceding non-empty lines
            tail -n +2 "$sourceFile" >> "$targetFile"
          }

          zola build
          cp -r public/* public/.* $out
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
