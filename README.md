# Minecraft Server on Docker

Portable Minecraft server project for running `VANILLA`, `PAPER`, `FABRIC`, `FORGE`, and other server types through Docker.

## Quick start

Run these commands on the Linux server:

```bash
make env
make up
```

Stop the server:

```bash
make down
```

## How it works

- `.env.example` contains all main settings
- `make env` creates `.env` from the example
- `compose.yaml` runs the server through `itzg/minecraft-server`
- `DATA_DIR=./data` is supported and resolved relative to this project directory

## Main settings

Edit `.env` and adjust:

- `SERVER_TYPE=VANILLA|PAPER|FABRIC|FORGE|NEOFORGE|PURPUR|SPIGOT`
- `MC_VERSION=26.2`
- `SERVER_NAME`
- `DATA_DIR=./data`
- `SERVER_PORT=25565`
- `MEMORY=4G`

## Useful commands

```bash
make doctor
make config
make logs
make ps
make restart
```
