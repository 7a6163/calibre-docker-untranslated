# Calibre Docker Untranslated

A Docker image based on linuxserver/calibre that integrates the calibre-do-not-translate-my-path patch to prevent Calibre from translating file paths.

## Features

- Based on the official linuxserver/calibre image
- Integrates the path non-translation patch
- Multi-architecture support (amd64, arm64)
- Weekly automated builds to keep up with the latest updates
- GitHub Container Registry distribution

## Requirements

- Docker installed on your system
- Sufficient storage space for your Calibre library
- Port 8080, 8081, and 8181 available on your host system

## Environment Variables

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `PUID` | User ID for permissions | Yes | `1000` |
| `PGID` | Group ID for permissions | Yes | `1000` |
| `TZ` | Timezone | Yes | `Etc/UTC` |
| `PASSWORD` | GUI password for remote access | No | not set |
| `CLI_ARGS` | Additional Calibre command line arguments | No | not set |

## Volumes

| Path | Description |
|------|-------------|
| `/config` | Contains all Calibre configuration files |
| `/library` | Location of your Calibre library |

## Ports

| Port | Description |
|------|-------------|
| `8080` | Calibre desktop GUI via browser |
| `8181` | Calibre desktop GUI via browser HTTPS |
| `8081` | Calibre content server |

## Usage

### Docker CLI

```bash
docker run -d \
  --name=calibre \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e PASSWORD= `#optional` \
  -e CLI_ARGS= `#optional` \
  -p 8080:8080 \
  -p 8181:8181 \
  -p 8081:8081 \
  -v /path/to/config:/config \
  -v /path/to/library:/library \
  --restart unless-stopped \
  ghcr.io/7a616/calibre-docker-untranslated:latest
```

### Docker Compose

Create a `docker-compose.yml` file:

```yaml
services:
  calibre:
    image: ghcr.io/7a616/calibre-docker-untranslated:latest
    container_name: calibre
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - PASSWORD= #optional
      - CLI_ARGS= #optional
    volumes:
      - /path/to/config:/config
      - /path/to/library:/library
    ports:
      - 8080:8080
      - 8181:8181
      - 8081:8081
    restart: unless-stopped
```

Then run:
```bash
docker-compose up -d
```

## Application Setup

- The WebUI can be accessed at `http://your-ip:8080` with an optional password set using the `PASSWORD` variable.
- HTTPS WebUI can be accessed at `https://your-ip:8181` with an optional password set using the `PASSWORD` variable.
- Calibre content server can be accessed at `http://your-ip:8081`
- The container uses the `seccomp:unconfined` flag to allow proper functioning of the Calibre GUI.

## Building Locally

To build the image locally:

```bash
git clone https://github.com/7a616/calibre-docker-untranslated.git
cd calibre-docker-untranslated
docker build -t calibre-docker-untranslated .
```

## Notes

- The container uses the calibre-do-not-translate-my-path patch (version 7.24.0)
- All the base functionality from linuxserver/calibre is preserved
- For more detailed information about Calibre itself, visit [Calibre's official website](https://calibre-ebook.com/)
- Available image tags:
  - `:latest` - Latest stable version
  - `:main` - Latest build from main branch
  - `:YYYYMMDD` - Weekly builds with date tag
  - `:v*.*.*` - Specific version releases

## Support

- For issues related to the Docker image, please open an issue on GitHub
- For Calibre-specific questions, refer to the [Calibre documentation](https://manual.calibre-ebook.com/)
- For base image related questions, refer to [linuxserver/calibre documentation](https://docs.linuxserver.io/images/docker-calibre/)
