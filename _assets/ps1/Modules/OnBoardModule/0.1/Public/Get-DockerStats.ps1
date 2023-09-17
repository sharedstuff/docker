Function Get-DockerStats {
    
    [CmdletBinding()]
    param ()

    Function Get-DockerStatsSplitAsDouble {

        [CmdletBinding()]
        param (

            [Parameter(Mandatory,ValueFromPipeline)]
            [string]
            $String,

            [Parameter(Mandatory)]
            [ValidateSet('Left', 'Right')]
            [string]
            $Type

        )

        process {
            $String | ForEach-Object {

                $Split = $_ -split " / " | ForEach-Object { 
                    $Return = $_.Replace('i',$null) 
                    if ($Return -match '\dB') { $Return = $Return.Replace('B',$null) }
                    [double]$Return
                }
                
                $Return = @{
                    Left = $Split[0]
                    Right = $Split[1]
                }
                             
                $Return.$Type

            }
        }

    }

    $TimeStamp = Get-Date -AsUTC -Format yyyy-MM-ddThh:mm:ssZ

    $Inspects = docker ps --format json | ConvertFrom-Json | Select-Object -ExpandProperty ID | ForEach-Object -Parallel {
        docker inspect $PSItem --format json | ConvertFrom-Json
    }
    
    # Labels."com.docker.compose.project.config_files" = composefile
    $DetailsWithStats = $Inspects | ForEach-Object -Parallel {
        $PSItem | Add-Member -MemberType NoteProperty -Name ComposeFile -Value $PSItem.Config.Labels.'com.docker.compose.project.config_files'
        $PSItem | Add-Member -MemberType NoteProperty -Name Stats -Value (docker stats $PSItem.Id --format json --no-stream | ConvertFrom-Json) 
        $PSItem
    }

    $DetailsWithStats | Select-Object @(
        
        @{
            n = 'Id'
            e = { $_.Id }
        }
        @{
            n = 'Name'
            e = { $_.Name.TrimStart('/') }
        }

        'ComposeFile'

        @{
            n = 'PIDs'
            e = { [int]($_.Stats.'PIDs') }
        }

        @{
            n = 'CPUPerc'
            e = { [double]$_.Stats.'CPUPerc'.TrimEnd('%') }
        }

        @{
            n = 'MemUsageUsedMB'
            e = { [math]::round(($_.Stats.'MemUsage' | Get-DockerStatsSplitAsDouble -Type Left) /1MB, 2) }
        }
        @{
            n = 'MemUsageLimitMB'
            e = { [math]::round(($_.Stats.'MemUsage' | Get-DockerStatsSplitAsDouble -Type Right) /1MB, 2) }
        }

        @{
            n = 'MemPerc'
            e = { [double]$_.Stats.'MemPerc'.TrimEnd('%') }
        }

        @{
            n = 'BlockIOWrittenMB'
            e = { [math]::round(($_.Stats.'BlockIO' | Get-DockerStatsSplitAsDouble -Type Left) /1MB, 2) }
        }
        @{
            n = 'BlockIOReadMB'
            e = { [math]::round(($_.Stats.'BlockIO' | Get-DockerStatsSplitAsDouble -Type Right) /1MB, 2) }
        }

        @{
            n = 'NetIOReceivedMB'
            e = { [math]::round(($_.Stats.'NetIO' | Get-DockerStatsSplitAsDouble -Type Left) /1MB, 2) }
        }
        @{
            n = 'NetIOSentMB'
            e = { [math]::round(($_.Stats.'NetIO' | Get-DockerStatsSplitAsDouble -Type Right) /1MB, 2) }
        }

        @{
            n = 'TimeStamp'
            e = { $TimeStamp }
        }

    )

}