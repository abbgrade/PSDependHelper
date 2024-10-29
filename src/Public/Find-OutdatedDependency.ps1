function Find-OutdatedDependency {
    
    [OutputType([Microsoft.PowerShell.Commands.ModuleSpecification])]
    [CmdletBinding()]
    param (
        # The directory, to scan for dependencies.
        [Parameter( Mandatory, ValueFromPipeline )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $Directory,

        # Specifies an array of one or more string patterns to be matched as the cmdlet gets child items. Any matching item is excluded from the output. Enter a path element or pattern, such as *.txt or A*. Wildcard characters are accepted.
        [Parameter()]
        [string[]] $Exclude
    )

    begin {
        $Dependencies = @()
    }

    process {
        $Dependencies += $Directory | ForEach-Object {
            $Dependencies1 = $_ | Get-ChildItem -Exclude $Exclude -Recurse -Include *.psd1, *.ps1 |
            ForEach-Object {
                $Dependencies2 = $_ | Import-Dependency
                $Dependencies2 | Add-Member ByFilePath $_.FullName
                $Dependencies2 | Write-Output
            }
            $Dependencies1 | Add-Member ByModuleName $_.Name
            $Dependencies1 | Write-Output
        }
    }

    end {
        $DependencyGroups = $Dependencies | Group-Dependency
        $DependencyGroups | Where-Object { $_.Version } | ForEach-Object {
            $group = $_
            $Dependencies | Where-Object {
                $_.Version
            } | Where-Object {
                $_.Name -eq $group.Name
            } | Where-Object {
                $_.Version -ne $group.Version
            } | ForEach-Object {
                $_ | Add-Member TargetVersion $group.Version
                $_ | Write-Output
            }
        }
    }
}