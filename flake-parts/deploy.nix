{
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: let
    deployScript = pkgs.writeScript "deploy.sh" ''
      export PATH="${lib.makeBinPath [
        pkgs.openssh
        pkgs.rsync
      ]}"

      rsync -a ${self'.packages.default}/ root@clan.lol:/var/www
    '';
  in {
    apps.deploy.program = "${deployScript}";
  };
}
