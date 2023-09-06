function Remove-DockerImage {

    <#

       .SYNOPSIS
        Remove Docker Images matching Regex

        .DESCRIPTION
        Remove Docker Images matching Regex

    #>


    [CmdletBinding()]
    param(

        # VariableName to be matched
        [Parameter(Mandatory)]
        [string]
        $VariableName,

        # Regex to match
        [Parameter(Mandatory)]
        [string]
        $Regex

    )

    DockerPS 'image ls' | Where-Object $VariableName -Match $Regex | ForEach-Object {
        $Image = '{0}:{1}' -f $_.Repository, $_.Tag
        docker image rm $Image
    }

}
