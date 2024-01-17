# Getting start with the repo

This is the source for the homepage.
We use [zola](https://www.getzola.org/) for building a static website.

## Build the homepage

This will build the website including pages defined in the clan-core repo under `/docs`:

```command
$ nix build
```

## Start a local webserver

This server will include all the pages from clan-core, but doesn't automatically refresh. Also make sure to wipe your browsers cache after each change.

```command
$ nix run .#serve
```

## zola build & serve
Alternatively `zola build` and `zola serve` can be used for development but the result will be missing the pages defined in the clan-core repo.

## Contributing

Send changes to https://git.clan.lol/clan/clan-homepage

## To update the website

```
$ nix run .#deploy
```


## Create a new post

```
$ nix run .#new-post "September Changelog"
```
