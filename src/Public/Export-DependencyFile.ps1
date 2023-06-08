function Export-DependencyFile {

    <#
    
    .SYNOPSIS
    Export dependencies as file

    .DESCRIPTION
    Convert a collection of ModuleSpecification objects into a PSDepend file.

    #>

    [OutputType([Microsoft.PowerShell.Commands.ModuleSpecification])]
    [CmdletBinding()]
    param (
        # The path where to create the dependency file.
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileInfo] $Path,
    
        # Specifies the dependency by module name and version
        [Parameter(Mandatory, ValueFromPipeline)]
        [Microsoft.PowerShell.Commands.ModuleSpecification] $Module
    )

    begin {
        $Modules = @()
    }

    process {
        $Modules += $Module
    }

    end {
        $Modules | ForEach-Object {
            [PSCustomObject]@{
                $_.Name = if ( $_.Version ) {
                    $_.Version
                }
                else {
                    'latest'
                }
            }
        } | 
        ConvertTo-Psd | 
        Set-Content -Path $Path
    }
}