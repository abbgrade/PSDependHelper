Describe Build-DependencyFile {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PSDependHelper.psd1 -Force -ErrorAction Stop
    }

    Context SimpleManifest {

        BeforeAll {
            [System.IO.DirectoryInfo] $Modules = "$TestDrive/simple_modules"
            New-Item $Modules -ItemType Directory
            [System.IO.FileInfo] $Manifest = "$Modules/test.psd1"
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
            Build-DependencyFile -Directory $Modules -Path $DependencyFile
            $DependencyFile | Should -Exist
            $Dependencies = Import-Psd $DependencyFile
            $Dependencies.LatestModule | Should -Be 'latest'
            $Dependencies.MinimumModule | Should -Be '1.0'
        }

    }

    Context ConflictingManifests {

        BeforeAll {
            [System.IO.DirectoryInfo] $Modules = "$TestDrive/conflicting_modules"
            New-Item $Modules -ItemType Directory

            [System.IO.FileInfo] $FirstManifest = "$Modules/first.psd1"
            New-ModuleManifest -Path $FirstManifest -RequiredModules `
            @{ 
                ModuleName    = 'TestModule' 
                ModuleVersion = '1.0'
            }

            [System.IO.FileInfo] $SecondManifest = "$Modules/second.psd1"
            New-ModuleManifest -Path $FirstManifest -RequiredModules `
                TestModule
        }

        It works {
            $DependencyFile = "$TestDrive/.depends.psd1"
            Build-DependencyFile -Directory $Modules -Path $DependencyFile
            $DependencyFile | Should -Exist
            $Dependencies = Import-Psd $DependencyFile
            $Dependencies.TestModule | Should -Be '1.0'
        }

    }

}