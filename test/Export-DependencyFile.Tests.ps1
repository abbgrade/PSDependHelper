Describe Export-DependencyFile {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PSDependHelper.psd1 -Force -ErrorAction Stop
        $VerbosePreference = 'Continue'
    }

    It works {
        $DependencyFile = "$TestDrive/.depends.psd1"
        @(
            (New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification 'First'),
            (New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification 'Second')
        ) | Export-DependencyFile -Path $DependencyFile
        $DependencyFile | Should -Exist
        $Dependencies = $DependencyFile | Import-Psd 
        $Dependencies | Should -HaveCount 1
        $Dependencies.First | Should -Be latest
        $Dependencies.Second | Should -Be latest
    }
}