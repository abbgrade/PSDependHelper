Describe Group-Dependency {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PSDependHelper.psd1 -Force -ErrorAction Stop
        $VerbosePreference = 'Continue'
    }

    It "works for <First> + <Second> -> <Expected>" -ForEach @(
        @{
            First = $null; Second = $null; Expected = $null
        },
        @{
            First = '1.0.0'; Second = $null; Expected = '1.0.0'
        },
        @{
            First = $null; Second = '1.0.0'; Expected = '1.0.0'
        },
        @{
            First = '1.0.0'; Second = '1.0.0'; Expected = '1.0.0'
        },
        @{
            First = '1.0.0'; Second = '2.0.0'; Expected = '2.0.0'
        }
    ) {

        $firstModule = New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification 'MyModule'
        if ($First) {
            $firstModule = New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification @{
                ModuleName = 'MyModule'
                ModuleVersion = $First 
            }
        }

        $secondModule = New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification 'MyModule'
        if ($Second) {
            $secondModule = New-Object -TypeName Microsoft.PowerShell.Commands.ModuleSpecification @{
                ModuleName = 'MyModule'
                ModuleVersion = $Second 
            }
        }

        $result = @( 
            $firstModule,
            $secondModule
        ) | Group-Dependency

        $result.Name | Should -Be MyModule
        $result.Version | Should -Be $Expected
    }
}