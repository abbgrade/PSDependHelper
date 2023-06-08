Describe Import-Dependency {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PSDependHelper.psd1 -Force -ErrorAction Stop
        $VerbosePreference = 'Continue'
    }

    Context Modules {
        BeforeAll {
            [System.IO.DirectoryInfo] $Modules = $TestDrive

            $Env:PSModulePath += [IO.Path]::PathSeparator + $TestDrive
        }

        Context Manifest {
            BeforeAll {
                [System.IO.FileInfo] $Manifest = Join-Path $Modules manifest.psd1
                New-ModuleManifest -Path $Manifest -RequiredModules `
                    LatestModule, `
                @{ 
                    ModuleName    = 'MinimumModule' 
                    ModuleVersion = '1.0'
                }
            }

            It works-from-parameters {
                $Dependencies = Import-Dependency -Path $Manifest
                $Dependencies | Where-Object Name -eq LatestModule | Select-Object -ExpandProperty Version | Should -Be $null
                $Dependencies | Where-Object Name -eq MinimumModule | Select-Object -ExpandProperty Version | Should -Be '1.0'
            }

            It works-from-pipeline {
                $Dependencies = $Manifest | Import-Dependency
                $Dependencies | Where-Object Name -eq LatestModule | Select-Object -ExpandProperty Version | Should -Be $null
                $Dependencies | Where-Object Name -eq MinimumModule | Select-Object -ExpandProperty Version | Should -Be '1.0'
            }
        }

        Context Script {
            BeforeAll {
                [System.IO.FileInfo] $Script = Join-Path $Modules script.ps1
                Set-Content -Path $Script -Value '#Requires -Modules LatestModule, @{ ModuleName="MinimumModule"; ModuleVersion="1.0" }'
            }

            It works-from-parameters {
                $Dependencies = Import-Dependency -Path $Script
                $Dependencies | Where-Object Name -eq LatestModule | Select-Object -ExpandProperty Version | Should -Be $null
                $Dependencies | Where-Object Name -eq MinimumModule | Select-Object -ExpandProperty Version | Should -Be '1.0'
            }

            It works-from-pipeline {
                $Dependencies = $Script | Import-Dependency
                $Dependencies | Where-Object Name -eq LatestModule | Select-Object -ExpandProperty Version | Should -Be $null
                $Dependencies | Where-Object Name -eq MinimumModule | Select-Object -ExpandProperty Version | Should -Be '1.0'
            }
        }

        Context InheritedDependency {

            BeforeAll {
                [System.IO.FileInfo] $First = Join-Path $Modules first.ps1
                Set-Content -Path $First -Value '#Requires -Modules second'

                [System.IO.FileInfo] $Second = Join-Path $Modules second second.psd1
                New-Item -ItemType Directory -Path $Second.Directory
                New-ModuleManifest -Path $Second -RequiredModules third
            }

            It works-from-parameters {
                $Dependencies = Import-Dependency -Path $First -Recurse
                $Dependencies | Where-Object Name -eq second | Should -Not -BeNullOrEmpty
                $Dependencies | Where-Object Name -eq third | Should -Not -BeNullOrEmpty
            }
        }
    }

}