function Build-DependencyFile {

    <#
    
    .SYNOPSIS
    Create a dependency file from the content of a directory.

    .DESCRIPTION
    Scan a directory for PowerShell manifests and scripts, extract the dependencies and create a PSDepend file.

    #>
    
    [OutputType()]
    [CmdletBinding()]
    param (
        # The directory, to scan for dependencies.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $Directory,

        # The path, where to create the file.
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileInfo] $Path
    )

    process {
        $Directory | 
        Get-ChildItem -Recurse -Include *.psd1, *.ps1 | 
        Import-Dependency |
        Group-Dependency | 
        Export-DependencyFile -Path $Path
    }
}