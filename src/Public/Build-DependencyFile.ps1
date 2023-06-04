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
                $output | Add-Member Module $_
                $output | Write-Output
            }
        }

        $dependencies | ForEach-Object {
            [PSCustomObject]@{
                $_.Module = 'latest'
            }
        } | ConvertTo-Psd | Set-Content -Path $Path
    }
}