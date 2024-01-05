. (Get-ChildItem $PSScriptRoot -Filter 'Install-Profile.ps1' -Recurse | Select-Object -First 1 -ExpandProperty FullName)
Install-Profile
