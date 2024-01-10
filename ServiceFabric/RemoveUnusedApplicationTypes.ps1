param(
    [Parameter(Mandatory = $true)][string]$AppTypeName
)

# Resolve all app types
$appTypes = Get-ServiceFabricApplicationType -ApplicationTypeName $AppTypeName
foreach($appType in $appTypes)
{
   # Try to find the match with any of installed applications
   $match = Get-ServiceFabricApplication -ApplicationTypeName $appType.ApplicationTypeName | Where-Object {$_.ApplicationTypeVersion -eq $appType.ApplicationTypeVersion}
   if(!$match)
   {
       Write-Host "Deleting $($appType.ApplicationTypeName) $($appType.ApplicationTypeVersion)"
       Unregister-ServiceFabricApplicationType -ApplicationTypeName $appType.ApplicationTypeName -ApplicationTypeVersion $appType.ApplicationTypeVersion -Force -Confirm
   }    
}