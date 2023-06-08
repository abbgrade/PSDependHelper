function Group-Dependency {

    <#

    .SYNOPSIS
    Group dependencies by module name.

    .DESCRIPTION
    Deduplicates dependencies and use the highest specified version.
    
    #>

    [OutputType([Microsoft.PowerShell.Commands.ModuleSpecification])]
    [CmdletBinding()]
    param (
        # Specifies the dependency by module name and version
        [Parameter(Mandatory, ValueFromPipeline)]
        [Microsoft.PowerShell.Commands.ModuleSpecification] $Module
    )

    begin {
        $Modules = @{}
    }

    process {
        if ( $Modules.ContainsKey($Module.Name) ) {
            $old = $Modules[$Module.Name].Version
            if ( -not $old ) {
                $old = New-Object System.Version
            }

            $new = $Module.Version
            if ( -not $new ) {
                $new = New-Object System.Version
            }

            if ( $old -lt $new ) {
                $Modules[$Module.Name] = $Module
            }
        }
        else {
            $Modules[$Module.Name] = $Module
        }
    }

    end {
        $Modules.Values
    }

}