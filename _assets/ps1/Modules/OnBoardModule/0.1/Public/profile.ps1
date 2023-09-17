'/root/.config/powershell/profile.ps1'

'Get/Set PSRepository PSGallery Trusted'
if (-not ((Get-PSRepository PSGallery).InstallationPolicy -eq 'Trusted')) { Set-PSRepository PSGallery -InstallationPolicy Trusted }

'Adding OnBoardModule to PSModulePath'
$ModulePath =  Get-Item (Join-Path $PSScriptRoot '../../..')
if ($Env:PSModulePath -notmatch $ModulePath) { $Env:PSModulePath += (':{0}' -f $ModulePath.FullName) }

'Install/Import Module DockerCompletion'
if (-not (Get-InstalledModule DockerCompletion -ErrorAction SilentlyContinue)) { Install-Module DockerCompletion }
if (-not (Get-Module DockerCompletion)) { Import-Module DockerCompletion }
