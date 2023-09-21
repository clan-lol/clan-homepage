# Getting start with the repo

This is the source for the homepage.
We use [zola](https://www.getzola.org/) for building a static website.

## Build the homepage

```
$ zola build
```

## Start a local webserver

```
$ zola serve
```

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
