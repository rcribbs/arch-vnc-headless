# [rcribbs/arch-vnc-headless](https://github.com/rcribbs/arch-vnc-headless)
[![GitHub Stars](https://img.shields.io/github/stars/rcribbs/arch-vnc-headless.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/rcribbs/arch-vnc-headless)
[![GitHub Release](https://img.shields.io/github/release/rcribbs/arch-vnc-headless.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/rcribbs/arch-vnc-headless/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/rcribbs/arch-vnc-headless.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/rcribbs/arch-vnc-headless)
[![Docker Stars](https://img.shields.io/docker/stars/rcribbs/arch-vnc-headless.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/rcribbs/arch-vnc-headless)

[Arch](https://archlinux.org/) is a lightweight and flexible Linux® distribution that tries to Keep It Simple.  
[Xfce](https://www.xfce.org/) is a lightweight desktop environment for UNIX-like operating systems.  
[TigerVNC](https://tigervnc.org/) is a high-performance, platform-neutral implementation of VNC (Virtual Network Computing), a client/server application that allows users to launch and interact with graphical applications on remote machines.  

## Description
This repo creates a docker image of Arch with Xfce, VNC and some essentials installed to act as an always-on remote workspace.

## Version Tags

This image provides various versions that are available via tags. `latest` tag usually provides the latest stable version. Others are considered under development and caution must be exercised when using them.

| Tag | Description |
| :----: | --- |
| latest | Stable releases |

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose ([recommended](https://docs.linuxserver.io/general/docker-compose))

Compatible with docker-compose v2 schemas.

```yaml
---
version: "2.1"
services:
  arch-vnc:
    image: rcribbs/arch-vnc-headless
    container_name: arch-vnc
    environment:
      - VNC_PASSWORD="s3cr3t"
      - CUSTOM_RESOLUTIONS="2048x1536,544x662"
    ports:
      - 5901:5901
    restart: unless-stopped
```

### docker cli

```
docker run -d \
  --name arch-vnc \
  -e VNC_PASSWORD="s3cr3t" \
  -e CUSTOM_RESOLUTIONS="2048x1536,544x662" \
  -p 5901:5901 
  --restart unless-stopped \
  rcribbs/arch-vnc-headless
```


## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 5901` | VNC port |
| `-e VNC_PASSWORD` | Password used to access VNC |
| `-e CUSTOM_RESOLUTIONS="2048x1536,544x662"` | A comma separated list of custom resolutions to add to xrandr |


## Operation
Once you run the image you can connect to it using the specified VNC port (Default is `5901`) using your client of choice (TigerVNC recommended). The default user will be the `docker` user with a default password of `changeme` and membership in the wheel group with sudo access.  

You may choose to keep this container around as your own image with `docker save` or just stopping/starting when needed. Be careful that by default (as with docker in general) nothing will be persisted if you delete the container without saving it to an image.

Though I haven't tested it, is image *should* be extendable as well if you wanted to build one with more dependencies pre-installed.
