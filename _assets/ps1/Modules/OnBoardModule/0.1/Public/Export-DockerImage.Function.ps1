function Export-DockerImage {

    <#

       .SYNOPSIS
        Export (Push) Docker Images matching Regex

        .DESCRIPTION
        Export (Push) Docker Images matching Regex

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
        docker push $Image
    }

}
