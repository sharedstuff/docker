Function Update-DockerImages {
    DockerPS image ls | Where-Object Repository -notlike "<none>" | ForEach-Object { '{0}:{1}' -f $_.Repository, $_.Tag  } | Sort-Object -Unique | ForEach-Object { docker pull $_ }
}


