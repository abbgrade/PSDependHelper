Describe Export-DependencyFile {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PSDependHelper.psd1 -Force -ErrorAction Stop
        $VerbosePreference = 'Continue'
    }

    It works {
        $DependencyFile = "$TestDrive/.depends.psd1"
        @(
            (New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification 'First')
        ) | Export-DependencyFile -Path $DependencyFile
        $DependencyFile | Should -Exist
    }
}