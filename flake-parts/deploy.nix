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

      if [ -n "$SSH_HOMEPAGE_KEY" ]; then
        sshExtraArgs="-i $SSH_HOMEPAGE_KEY"
      else
        sshExtraArgs=
      fi

      rsync \
        -e "ssh -o StrictHostKeyChecking=no $sshExtraArgs" \
        -a ${self'.packages.default}/ \
        www@clan.lol:/var/www
    '';
  in {
    apps.deploy.program = "${deployScript}";
  };
}
