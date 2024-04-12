{
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: let
    deployScript = pkgs.writeScript "deploy.sh" ''
      export PATH="${lib.makeBinPath [
        pkgs.coreutils
        pkgs.openssh
        pkgs.rsync
      ]}"

      if [ -n "$SSH_HOMEPAGE_KEY" ]; then
        echo "$SSH_HOMEPAGE_KEY" > ./ssh_key
        chmod 600 ./ssh_key
        sshExtraArgs="-i ./ssh_key"
      else
        sshExtraArgs=
      fi

      rsync \
        -e "ssh -o StrictHostKeyChecking=no $sshExtraArgs" \
        -a ${self'.packages.default}/ \
        www@clan.lol:/var/www/clan.lol

      if [ -e ./ssh_key ]; then
        rm ./ssh_key
      fi
    '';
  in {
    apps.deploy.program = "${deployScript}";
  };
}
