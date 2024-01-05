$MyInvocation.MyCommand.Source

$Start = Get-Date

if ($IsLinux) { $PathDelimiter = ':' }
elseif ($IsWindows) { $PathDelimiter = ';' }

'Ensuring presence of OnBoardModulePath in $Env:PSModulePath'
$OnBoardModulePath = 'ReplacedByInstall-Profile.ps1'
if ($Env:PSModulePath -notmatch $OnBoardModulePath) {
    $Env:PSModulePath = $OnBoardModulePath, $Env:PSModulePath -join $PathDelimiter
}

$End = Get-Date

$TimeSpan = New-TimeSpan -Start $Start -End $End
'Loading profile.ps1 took {0} Milliseconds' -f $TimeSpan.TotalMilliseconds
