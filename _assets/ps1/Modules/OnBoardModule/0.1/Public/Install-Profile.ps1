Function Install-Profile {

    [CmdletBinding()]
    param (
        $Path = (Join-Path $PSScriptRoot 'profile.ps1'),
        $Destination = '~/.config/powershell'
    )
       
    if (Test-Path $Path) {
        if (-not (Test-Path $Destination)) { New-Item $Destination -ItemType Directory }
        $Content = (Get-Content $Path).Replace('$PSScriptRoot',$PSScriptRoot)
        $Content
        $Content | Out-File "$Destination/profile.ps1" -Verbose -Confirm
    }
   
}