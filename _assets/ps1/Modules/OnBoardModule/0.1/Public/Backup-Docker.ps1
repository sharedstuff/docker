Function Backup-Docker {

    param (
        $DockerPath = '/docker',
        $BackupPath = '/media/sda'
    )

    $StartLocation = Get-Location

    try {

        try { $null = Stop-Transcript } catch {}

        $TimeStamp = Get-Date -Format FileDateTimeUniversal
        $TranscriptLocation = Join-Path $BackupPath ('docker-{0}.log' -f $TimeStamp)
        $BackupLocation = Join-Path $BackupPath ('docker-{0}.tar' -f $TimeStamp)

        Set-Location $DockerPath
        Start-Transcript -Path $TranscriptLocation -UseMinimalHeader

        'Compose Down'
        Invoke-DockerCompose -Action Down

        # cvpWlf
        # c create
        # v verbose
        # p keep permissions
        # W verify
        # l kinks
        # f use archive file
        # -C / <-- root for verification
        'tar'
        tar cvpWlf "$BackupLocation" -C / "$DockerPath"

        'Compose Up'
        Invoke-DockerCompose -Action Up

        'successful'
        Stop-Transcript
        Set-Location $StartLocation

    }
    catch {
        'error'
        $_
        Stop-Transcript
        Set-Location $StartLocation
    }

}
