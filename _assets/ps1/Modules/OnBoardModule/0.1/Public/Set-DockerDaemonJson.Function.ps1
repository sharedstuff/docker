Function Set-DockerDaemonJson {

    <#

        .SYNOPSIS
        Creates a daemon.json configuration from a PSObject representation

        .DESCRIPTION
        Creates a daemon.json configuration from a PSObject representation

    #>

    [CmdletBinding()]
    param (

        # PSObject representation of the daemon.json file
        [Parameter(ValueFromPipeline)]
        [object]
        $InputObject = [ordered]@{
            experimental            = $true
            'fixed-cidr'            = '172.16.0.0/24'
            'fixed-cidr-v6'         = 'fd00::1:0/120'
            ip6tables               = $true
            ipv6                    = $true
            'default-address-pools' = @(
                [ordered]@{
                    base = '172.17.0.0/16'
                    size = 24
                },
                [ordered]@{
                    base = 'fd00::2:0/112'
                    size = 120
                }
            )
        },

        # Path to the hosts daemon.json file
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $Path = '/etc/docker/daemon.json'

    )

    begin {
        $MyInvocation.MyCommand.Name | Write-Verbose
    }

    process {
        $Json = $InputObject | ConvertTo-Json -Depth 99
        $Json | Write-Verbose
        $Json | Set-Content -Path $Path
    }

}
