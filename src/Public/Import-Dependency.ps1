function Import-Dependency {

    <#
    
    .SYNOPSIS
    Import dependencies from PowerShell scripts and manifests.

    #>

    [OutputType([Microsoft.PowerShell.Commands.ModuleSpecification])]
    [CmdletBinding()]
    param (
        # Path to the PowerShell script or manifest.
        [Parameter( Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName )]
        [ValidateScript({ $_.Exists })]
        [Alias('FullName')]
        [System.IO.FileInfo] $Path,

        # If set, dependencies of required modules are imported recursively.
        [Parameter()]
        [switch] $Recurse
    )

    begin {
        $Script:ImportedModules = @()
    }

    process {
        $Path | ForEach-Object {
            Write-Verbose "Scanning $_"
            switch ( $_.Extension ) {
                .psd1 {
                    $Path | 
                    Import-Psd |
                    Select-Object -ExpandProperty RequiredModules -ErrorVariable RequiredModulesError -ErrorAction SilentlyContinue |
                    ForEach-Object {
                        New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification $_
                    }

                    if ( $RequiredModulesError ) {
                        Write-Warning "$RequiredModulesError in '$( $input[0] )'."
                    }
                    
                }
                .ps1 {
                    [System.Management.Automation.Language.ScriptBlockAst] $scriptBlockAst = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$null, [ref]$null)
                    $scriptBlockAst | 
                    Select-Object -ExpandProperty ScriptRequirements |
                    Select-Object -ExpandProperty RequiredModules
                }
                default {
                    Write-Warning "$_ is not supported"
                }
            }
        } | ForEach-Object {
            Write-Output $_

            if ( $Recurse.IsPresent ) {
                $_ | 
                Where-Object Name -NotIn $Script:ImportedModules | 
                ForEach-Object {
                    $Script:ImportedModules += $_.Name
                    Get-Module -ListAvailable -Name $_.Name | 
                    Import-Dependency -Recurse:$Recurse
                }
            }
        }
    }
}