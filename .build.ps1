$ModuleName = 'PSDependHelper'

. $PSScriptRoot/tasks/Build.Tasks.ps1
. $PSScriptRoot/tasks/PsBuild.Tasks.ps1

task InstallBuildDependencies -Jobs {
    Install-Module PsdKit
    Install-Module platyPs
}
task InstallTestDependencies -Jobs {}
task InstallReleaseDependencies -Jobs {}