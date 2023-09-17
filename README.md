# docker  
A set of Docker examples  
  
# Conventions  
The following conventions are made  
  
## Folder structure  
### single service  
```
\service
  docker-compose.yml
  \config
  \data
```
### stack  
```
\stack
  docker-compose.yml  
  \config
  \data
  \service
    \config
    \data
```

## Network: IPv6  
All examples utilize IPv6
https://github.com/sharedstuff/Docker-IPv6-HowTo  
  
## Network: traefik  
All examples rely on a network called "traefik" to connect to the reverse proxy  
```
docker network create --ipv6 --subnet 172.18.0.0/16 --subnet fd00::3:0/112 traefik
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
  
## sh  
- `install-docker.sh`  
  a simple docker install script  
- `install-powershell.sh`  
  a simple powershell install script  
  
# Demo  
see a live demo on:  
https://homepage.mein-reverseproxy.de  
  