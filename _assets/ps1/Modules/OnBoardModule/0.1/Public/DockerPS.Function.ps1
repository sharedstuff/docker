function DockerPS {

    <#

       .SYNOPSIS
        Invokes a Docker expression - outputs a PowerShell object

        .DESCRIPTION
        Invokes a Docker expression - outputs a PowerShell object
        Simple function to force Docker to output in json format and convert that output to a PowerShell object

        .EXAMPLE
        PS> DockerPS image ls

    #>

    $InvokeExpression = 'docker {0} --format json | ConvertFrom-Json -Depth 99' -f ($args -join ' ')
    Invoke-Expression $InvokeExpression

}
