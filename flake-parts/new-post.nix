{
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: {
    apps.new-post.program = builtins.toString (pkgs.writeShellScript "new-post.sh" ''
      export PATH="${lib.makeBinPath [
        pkgs.coreutils pkgs.gitMinimal
      ]}"
      if [ -z "$1" ]; then
        echo "Usage: new-post.sh <title>"
        exit 1
      fi
      title=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
      root=$(git rev-parse --show-toplevel)
      fname="$root/content/blog/$(date +%Y-%m-%d)-$title.md"
      if [ -f "$fname" ]; then
        echo "File already exists: $fname"
        exit 1
      fi
      cat <<EOF > "$fname"
      +++
      title = "$1"
      date = "$(date --iso-8601=seconds)"
      draft = true
      template = "blog/page.html"
      [taxonomies]
      authors = [] # TODO
      [extra]
      lead = "Some lead"
      +++

      Some text
      EOF
      echo "Created $fname"
      git add "$fname"
    '');
  };
}
