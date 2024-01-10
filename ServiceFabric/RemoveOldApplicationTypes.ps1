param(
    [Parameter(Mandatory = $true)][string]$AppTypeName,
    [Parameter(Mandatory = $false)][int]$CountToKeep
)

if(!$CountToKeep)
{
    $CountToKeep = 2
}

# Resolve all app types
$appTypes = Get-ServiceFabricApplicationType -ApplicationTypeName $AppTypeName
$deployedAppArray = @()
foreach($appType in $appTypes){    
    # Try to find the match with any of installed applications
    $match = Get-ServiceFabricApplication -ApplicationTypeName $appType.ApplicationTypeName | Where-Object {$_.ApplicationTypeVersion -eq $appType.ApplicationTypeVersion}
    if(!$match)
    {
        $oldApp = new-object psobject -property @{
            ApplicationTypeName = $appType.ApplicationTypeName
            ApplicationTypeVersion  = $appType.ApplicationTypeVersion 
        }
        $deployedAppArray += $oldApp
    }    
}

$uniqueAppTypes = $deployedAppArray | Group-Object "ApplicationTypeName" | Where-Object { $_.Count -gt $CountToKeep } | Select-Object -ExpandProperty Name

foreach($appType in $uniqueAppTypes){ 
    $versionsToRemove = $deployedAppArray | Where-Object {$_.ApplicationTypeName -eq $appType}
    $toRemoveCount =  $versionsToRemove.Length - $CountToKeep
    $versionsToRemove = $versionsToRemove | Select-Object -First $toRemoveCount

    foreach($appToRemove in $versionsToRemove){
        Write-Host "Removing $($appToRemove.ApplicationTypeName) $($appToRemove.ApplicationTypeVersion)"
        Unregister-ServiceFabricApplicationType -ApplicationTypeName $appToRemove.ApplicationTypeName -ApplicationTypeVersion $appToRemove.ApplicationTypeVersion -Force
    }
}