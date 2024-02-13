# docker  
A set of Docker examples  
  
# Conventions  
The following conventions are made  
  
## Folder structure  
```
\stack
  docker-compose.yml
  \config
    .env
    ...
    \service-a
    \service-b
    ...
  \data
    \volume-a
    \volume-b
    ...

```

## Network: IPv6  
All examples utilize IPv6
https://github.com/sharedstuff/Docker-IPv6-HowTo  
  
## Network: traefik  
All examples rely on a pre-created network  
```
docker network create --ipv6 --subnet 172.18.0.0/24 --subnet fd00::18:0/112 traefik
```
  
# Assets included  
  
## docker  
  
- `daemon.json`  
  daemon configuration - taken from "Network: IPv6"  

- `docker-compose-template.yml`  
  a docker compose template  
  
## ps1  
OnBoardModule  
  
- `Backup-Docker`  
  a simple backup script  

- `DockerPS`  
  wrapper for docker executeable  

- `Export-DockerImage`  
  push-helper  

- `Get-DockerStats`  
  retrieve Docker stats as PSObject  

- `Install-Profile`  
  Install a basic profile  

- `Invoke-DockerCompose`  
  wrapper for docker compose  

- `Remove-DockerImage`  
  removes docker images matching a regex  
  
-`Set-DockerDaemonJson`  
  sets the Docker daemon file  
  
-`Set-DockerNetworks`  
  sets/creates custom networks  
  
-`Update-DockerImages`  
  wrapper for docker pull  
  
## sh  
- `install-docker.sh`  
  a simple docker install script  
  
- `install-powershell.sh`  
  a simple powershell install script  
  