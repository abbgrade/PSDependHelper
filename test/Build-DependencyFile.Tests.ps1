Describe Build-DependencyFile {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PSDependHelper.psd1 -Force -ErrorAction Stop
    }

    Context Manifest {

        BeforeAll {
            [System.IO.FileInfo] $Manifest = "$TestDrive/modules/test.psd1"
            New-Item $Manifest.Directory -ItemType Directory
            New-ModuleManifest -Path $Manifest -RequiredModules `
                LatestModule, `
            @{ 
                ModuleName    = 'MinimumModule' 
                ModuleVersion = '1.0'
                # }, `
                # @{ 
                #     ModuleName    = 'MaximumModule' 
                #     MaximumVersion = '1.0'
                # }, `
                # @{ 
                #     ModuleName    = 'RequiredModule' 
                #     RequiredVersion = '1.0'
            }
        }

        It works {
            $DependencyFile = "$TestDrive/.depends.psd1"
            Build-DependencyFile -Directory "$TestDrive/modules" -Path $DependencyFile
            $DependencyFile | Should -Exist
            $Dependencies = Import-Psd $DependencyFile
            $Dependencies.LatestModule | Should -Be 'latest'
            $Dependencies.MinimumModule | Should -Be '1.0'
        }

    }

}