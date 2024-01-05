Function Invoke-DockerCompose {

    [CmdletBinding()]
    param (

        [ValidateSet('Restart', 'Up', 'Down')]
        [string]
        $Action = 'Up',

        [string]
        $Name,

        [string]
        $Filter = '*docker-compose.y*ml',

        [switch]
        $Pull,

        [switch]
        $NoBuild,

        [switch]
        $NoDetach,

        [switch]
        $NoForceRecreate,

        [switch]
        $NoRemoveOrphans,

        [switch]
        $NoRenewAnonVolumes,

        [int]
        $ThrottleLimit = 4,

        [int]
        $Depth = 2

    )

    $PSDefaultParameterValues['ForEach-Object:ThrottleLimit'] = $ThrottleLimit

    'Performing Action: "{0}"' -f $Action

    # Get and filter files
    $Files = Get-ChildItem -Recurse -File -Filter $Filter -Depth $Depth | Select-Object -ExpandProperty FullName
    if ($Name) { $Files = $Files | Where-Object { $_ -match $Name } }

    'Found the following docker-compose files (matching *docker-compose.y*ml):'
    $Files

    # 'switch action to boolean up&down'
    switch ($Action) {
        'Restart' {
            $Up = $true
            $Down = $true
        }
        'Up' {
            $Up = $true
            $Down = $false
        }
        'Down' {
            $Up = $false
            $Down = $true
        }
    }

    # 'set specific params to actions'
    $ComposeParams = @{
        up   = @()
    }

    if ($Pull) { $ComposeParams.Up += '--pull always' }
    if (-not $NoBuild) { $ComposeParams.Up += '--build' }
    if (-not $NoForceRecreate) { $ComposeParams.Up += '--force-recreate' }
    if (-not $NoDetach) { $ComposeParams.Up += '-d' }
    if (-not $NoRemoveOrphans) { $ComposeParams.Up += '--remove-orphans' }
    if (-not $NoRenewAnonVolumes) { $ComposeParams.Up += '--renew-anon-volumes' }

    # 'getEnumerator'
    $ComposeParamStrings = @{}
    $ComposeParams.GetEnumerator() | ForEach-Object {
        $Name = $_.Name
        $ComposeParamStrings.$Name = ($ComposeParams.$Name -join ' ').Trim()
    }

    # 'a collection of expressions we want to execute'
    $Expressions = @('down', 'up') | ForEach-Object {
        if (Get-Variable -Name $_ -ValueOnly) {
            $Task = $_
            $Files | ForEach-Object {
                'docker compose -f "{0}" {1} {2}' -f $PSItem, $Task, $ComposeParamStrings.$Task
            }
        }
    }

    # Output
    'Expressions'
    $Expressions

    # Do
    $Expressions | ForEach-Object -Parallel { $PSItem | Invoke-Expression }

}
