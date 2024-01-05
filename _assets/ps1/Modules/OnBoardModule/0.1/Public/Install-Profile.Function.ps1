Function Install-Profile {

    [CmdletBinding()]
    param (
        $Path = (Join-Path $PSScriptRoot 'profile.ps1'),
        $Destination = '~/.config/powershell'
    )

    if (-not (Test-Path $Destination)) { New-Item $Destination -ItemType Directory }

    $OnBoardModulePath = (Get-Item (Join-Path $PSScriptRoot '../../..')).FullName

    $Content = (Get-Content $Path).Replace('ReplacedByInstall-Profile.ps1', $OnBoardModulePath)
    $Content

    $Content | Set-Content "$Destination/profile.ps1" -Verbose -Confirm

}
