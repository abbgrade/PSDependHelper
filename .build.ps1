$ModuleName = 'PSDependHelper'

. $PSScriptRoot/tasks/Build.Tasks.ps1
. $PSScriptRoot/tasks/PsBuild.Tasks.ps1

task InstallModuleDependencies -Jobs {
    Install-Module PsdKit
}

task InstallBuildDependencies -Jobs InstallModuleDependencies, {
    Install-Module platyPs
}
task InstallTestDependencies -Jobs InstallModuleDependencies
task InstallReleaseDependencies -Jobs InstallModuleDependencies