#
# ImportFramework.ps1
#

$currentfolder = $PSScriptRoot.ToString()
Import-Module ($currentfolder + "\Newtonsoft.Json.dll") -Verbose

$importfolder = $currentfolder + "\BPCloudTestFramework\bin\Debug\"

cd $importfolder
Import-Module .\BPCloudTestFramework.dll -Verbose
cd $currentfolder

$servicebus = "Endpoint=sb://buzzplus-dev-ghorvath-ns.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=809c/dFqmNxvP3VrEh5BcXCg6TjZ4FLlAqScBpU5ZH8="

$interId = New-BPGuid
