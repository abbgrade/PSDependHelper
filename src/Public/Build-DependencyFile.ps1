function Build-DependencyFile {
    
    [CmdletBinding()]
    param (
        [Parameter()]
        [System.IO.DirectoryInfo] $Directory,

        [Parameter( Mandatory )]
        [System.IO.FileInfo] $Path
    )

    process {
        $dependencies = $Directory | Get-ChildItem -Recurse -Include *.psd1 | ForEach-Object {
            Write-Verbose "Process $_"

            $data = Import-Psd $_

            $outputTemplate = [PSCustomObject]@{
                Source = $_.BaseName
            }

            $data.RequiredModules | ForEach-Object {
                $output = $outputTemplate.PSObject.Copy()
                if ( $_ -is [string] ) {
                    $output | Add-Member Module $_
                    $output | Add-Member Version latest
                } elseif ( $_.ModuleName -and $_.ModuleVersion ) {
                    $output | Add-Member Module $_.ModuleName
                    $output | Add-Member Version $_.ModuleVersion
                } else {
                    Write-Error "Unsupported required module $_"
                }
                $output | Write-Output
            }
        }

        $dependencies | ForEach-Object {
            [PSCustomObject]@{
                $_.Module = $_.Version
            }
        } | ConvertTo-Psd | Set-Content -Path $Path
    }
}