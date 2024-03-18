## Clan Demo Material Guide

Welcome to the Clan Demo Material repository. This guide outlines how to prepare and integrate video content for Clan-related projects and documentation.

### Video Editing and Preparation

- **Editor**: Edit videos using the [Olive Video Editor](https://www.olivevideoeditor.org/), a robust, open-source video editing tool.
- **Project Files**: Save your work with the `.ove` extension, which signifies Olive Video Editor project files. These files can be reopened and edited in Olive Video Editor.

#### Video Specifications

Please follow these specifications for creating videos to ensure uniformity and compatibility:

- **Resolution**: Aim for a 1920x1080 resolution to maintain a standard of high quality.
- **Encoding**: Utilize AV1 encoding, balancing quality with efficient file size.
- **Format**: Export videos in the `.webp` format. This format allows for high compression without sacrificing quality.
- **Compression**: Apply high compression to minimize file sizes while preserving clarity.
- **Audio**: Omit audio tracks, focusing exclusively on visual content.

### Embedding Videos in HedgeDoc

To incorporate a video into a HedgeDoc document, embed it using the HTML `iframe` tag. Replace `<base_url>` with the actual URL of the hosted video file.

```html
<iframe width="560" height="315" src="<base_url>/show_join.webm" title="Joining a Clan over the UI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
```

#### Whitelisting URLs for Embedding

To enable external iframe embeddings, such as embedding videos hosted on your platform into HedgeDoc, ensure the URL is whitelisted in your Nginx configuration. Here’s an example for Gitea integration:

```nix
services.nginx.virtualHosts."git.clan.lol" = {
  forceSSL = true;
  enableACME = true;
  locations."/".extraConfig = ''
    proxy_pass http://localhost:3002;
    add_header Content-Security-Policy "frame-ancestors 'self' https://pad.lassul.us";
  '';
};
```

This Nginx configuration snippet includes the `add_header` directive to set the Content-Security-Policy header. It specifically allows embedding content from `git.clan.lol` in an iframe within `https://pad.lassul.us`.

