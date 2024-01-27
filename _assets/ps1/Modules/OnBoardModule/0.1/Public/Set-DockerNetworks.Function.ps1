function Set-DockerNetworks {

    <#

        .SYNOPSIS
        (Re)Sets (Creates) custom Docker networks from a PSObject representation

        .DESCRIPTION
        (Re)Sets (Creates) custom Docker networks from a PSObject representation

    #>


    [CmdletBinding()]
    param (

        # PSObject representation of the daemon.json file
        [Parameter(ValueFromPipeline)]
        [object[]]
        $InputObjectArray = @(
            @{
                Name     = 'traefik'
                SubnetV4 = '172.18.0.0/24'
                SubnetV6 = 'fd00::3:0/120'
                Recreate = $true
            }
            @{
                Name     = 'dns'
                SubnetV4 = '172.19.0.0/24'
                SubnetV6 = 'fd00::4:0/120'
                Recreate = $true
            }
        )

    )

    begin {
        $MyInvocation.MyCommand.Name | Write-Verbose
    }

    process {
        ForEach ($InputObject in $InputObjectArray) {
            if ($InputObject.Recreate) { docker network rm $InputObject.Name | Write-Verbose }
            docker network create --subnet $InputObject.SubnetV4 --subnet $InputObject.SubnetV6 $InputObject.Name && docker network inspect $InputObject.Name | Write-Verbose
        }
    }

}
