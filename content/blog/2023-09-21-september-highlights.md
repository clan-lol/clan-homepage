+++
title = "Highlights from September"
date = "2023-09-21T12:50:17+02:00"
draft = false
template = "blog/page.html"
[taxonomies]
authors = [] # TODO
[extra]
lead = "Hello friends,"
+++

We are proudly presenting the progress on the [clan](https://clan.lol/blog/hello-world/) project.
This article will become a monthly on-going blog series about cool
new features that we added to it.

With clan we want to make it easier to create and manage networks called clans for your friends, communities or small buisnesses.
Administrators can publish a configuration that decribes a clan on the internet.
Users can join a clan by either installing the Linux distribution [NixOS](https://nixos.org/) on their PC/Laptop based on the clan configuration
or by installing the nix package manager followed by downloading a NixOS-based virtual machine defined in the clan.
The physical or virtual machines than will connect to a decentralized VPN.

As a first step we focused on making it easier to manage clan based machines.
At this time this still requires knowledge about [NixOS](https://nixos.org/) on the side of the adminstrator
and our current focus is to reduce the amount of knowledge required for users, that don't need to modify configuration.

In rest of the article we will present the features we have implemented so far:

In clan we are working on two user interfaces, a command-line based management that allows power-users to efficiently manage clan networks
and a web-based ui that can give were also Users without NixOS can do more high-level modifications to configure machines or
just start a virtual machines.

# CLI

## A flake template to build your own clan

In our [quickstart guide](https://git.clan.lol/clan/clan-core/src/branch/main/docs/quickstart.md) we explain
on how to create a new clan configuration and add new machines or migrate existing NixOS flakes to clan compatible format.

## Secrets cli & secrets generation and integration into NixOS

For many networked applications where we communicate with other machines, we need a way to share secrets in a secure way.
Furthermore we want to have a form of access control that manages who can read what secret.
As this can be tedious to set up, we create a new CLI to manage secrets with NixOS that accessible under `clan secrets`.
The clan cli allows to quickly add or read new secrets manually:

```console
$ clan secrets set mysecret
$ clan secrets get mysecret
```

The secrets themself are stored encrypted using the [sops](https://github.com/mozilla/sops) encryption tool in the clan configuration.
Each user and machine have an encryption key that can decrypt these secrets.
When creating new secrets a user can list machines, user or groups of machines/users that can decrypt a secret:

```console
$ clan secrets set --machine eve --group admins mysecret
```

Secrets encrypted for a machine are automatically into the machine and can be accessed via `config.sops.secrets.<name>.path`.

When maintaining multiple machines it also becomes tedious to manually regenerate and store secrets per machine.

See the [secrets guide](https://git.clan.lol/clan/clan-core/src/branch/main/docs/secrets-management.md) for more information.

## Update command for remote machines

NixOS allows to manage multiple machines in a single central configuration.
In clan we make use of that and provide a command that can remotly update all your machines:

```console
$ clan machines update <machine>
```

This will copy the clan configuration to the remote machine,
start downloading and building the new system on the target.

## Configuration cli

In addition to manually editing NixOS configurations, Clan offers a Configuration Command Line Interface (CLI).
This feature enhances convenience by permitting users to efficiently read and write NixOS options for individual machines.

```console
$ clan config --machine my-machine services.openssh.enable
false
$ clan config --machine my-machine services.openssh.enable true
New Value for services.openssh.enable:
true
```

In this example, the `clan config` command is used to query the `services.openssh.enable` setting for a machine named `my-machine`.
The output `false` indicates that the OpenSSH service is currently disabled.
The same command is then used to enable the OpenSSH service, by setting the `services.openssh.enable` option to `true`.

In future updates, this functionality will be incorporated into a web interface.
This enhancement will empower even those without programming experience to effortlessly modify settings for their machines.

<!--
## Image generation

```console
$ nix build git+https://git.clan.lol/git#install-iso
$ dd status=progress conv=sync bs=128M if=./result of=/dev/sda
```

builds an iso image that boots the installer, it prints a QR code after startup which can be scanned with

- qrcode has the root password and connection url
- connection url is based on tor -> hidden service for ssh
  `$ nix run '.#' -- ssh` scan?
-->

## Automatic VPN configuration

- designated a machine as the vpn controler in the clan
- add

```nix
clan.networking.zerotier.controller = {
  enable = true;
  public = true;
};
```
  to config
- run `clan machines update <CONTROLLER>`
- in new_machine add `builtins.readFile (config.clanCore.clanDir + "/machines/<CONTROLLER>/facts/zerotier-network-id");` to the config. Replace `<CONTROLLER>` with the machine
  name of the controller.
- run clan machines update new_machine
- In controller run `zerotier-members list` to list all peers
- `new_machine`: `sudo zerotier-cli info` to get the zerotier id 
- Controller: run `zerotier-members allow <id>`
- `new_machine`: `sudo zerotier-cli info` should now "ONLINE" in its statsu

# UI

## UI to join Clans via url and spawn VM

- Admin shares: http://localhost:2979/join.html?flake=github:Mic92/my-clan&attr=vm1
- User runs: `nix run "git+https://git.clan.lol/clan/clan-core" -- webui`
- User clicks: http://localhost:2979/join.html?flake=github:Mic92/my-clan&attr=vm1

<!--
## Cool features we will support until the end of the month

- Secrets cli & secrets generation and integration into NixOS
- Update command for remote machines
  - for one machine
- Config cli
    ```shellSession
    $ clan config --machine my-machine services.openssh.enable
    false
    $ clan config --machine my-machine services.openssh.enable true
    New Value for services.openssh.enable:
    true
    ```
- Image generation:
  `$ nix build install-iso`
  `$ dd status=progress conv=sync bs=128M if=./result of=/dev/sda`
  builds an iso image that boots the installer, it prints a QR code after startup which can be scanned with
  - qrcode has the root password and connection url
  - connection url is based on tor -> hidden service for ssh
  `$ nix run `.#` -- ssh` scan?
- Automatic VPN configuration

## On the roadmap for next month

- Installation via ssh
- Backups
- UI to configure VMs?
- [ ]  What was the status of this?
-->
```
