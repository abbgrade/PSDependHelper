$ModuleName = 'PSDependHelper'

. $PSScriptRoot/tasks/Build.Tasks.ps1
. $PSScriptRoot/tasks/PsBuild.Tasks.ps1

task InstallBuildDependencies -Jobs {
    Install-Module PsdKit
}
task InstallTestDependencies -Jobs {}
task InstallReleaseDependencies -Jobs {}