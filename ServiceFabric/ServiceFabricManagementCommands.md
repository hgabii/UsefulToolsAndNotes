# Service Fabric Management Commands

## SF cluster connections

### Connect to local cluster

```powershell
Connect-ServiceFabricCluster -ConnectionEndpoint "localhost:19000"
```

## Connect to Service Fabric cluster in Azure

```powershell
Connect-ServiceFabricCluster -ConnectionEndpoint "[Client connection endpoint]" -AzureActiveDirectory -ServerCertThumbprint "[Cluster certificates thumbprint]"
```

## New application

```powershell
New-ServiceFabricApplication -ApplicationName fabric:/MyOwnAppName -ApplicationTypeName "MyOwnAppType" -ApplicationTypeVersion "" -ApplicationParameter
```

## Update application

```powershell
Start-ServiceFabricApplicationUpgrade -UnmonitoredAuto -ApplicationName fabric:/MyOwnAppName -ApplicationTypeVersion "" -ApplicationParameter
```

## Remove application

```powershell
Remove-ServiceFabricApplication -ApplicationName fabric:/MyOwnAppName
```

## Force remove application service

```powershell
Remove-ServiceFabricService -ServiceName fabric:/MyOwnAppName/MyOwnService -ForceRemove
```

## Create new service

```powershell
New-ServiceFabricService -Stateless -PartitionSchemeSingleton -ApplicationName fabric:/MyOwnAppName -ServiceName fabric:/MyOwnAppName/MyOwnService -ServiceTypeName MyOwnServiceType -InstanceCount 1 -DefaultMoveCost Zero -ServicePackageActivationMode ExclusiveProcess
```

## How to export SF cluster certificate

> [!NOTE]
> When import, check "be exportable"

```powershell
[System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes("C:\temp\certs\cert-with-pwd.pfx"))
```

## How to manually deploy SF application package

1. Copy the Application Package to the Image Store

    ```powershell
    Copy-ServiceFabricApplicationPackage -ApplicationPackagePath "c:\MyOwnAppName\pkg\Release" -ApplicationPackagePathInImageStore "MyOwnAppName\my_image"
    ```

1. Register Application Package

    ```powershell
    Register-ServiceFabricApplicationType -ApplicationPathInImageStore "MyOwnAppName\my_image" -TimeoutSec 600
    ```

1. Remove Application Package from Image Store

    ```powershell
    Remove-ServiceFabricApplicationPackage -ApplicationPackagePathInImageStore "MyOwnAppName\my_image" -ImageStoreConnectionString fabric:ImageStore
    ```

1. Upgrade or create new Application

    - Update:

        ```powershell
        Start-ServiceFabricApplicationUpgrade -HealthCheckStableDurationSec 60 -UpgradeDomainTimeoutSec 1200 -UpgradeTimeout 3000 -FailureAction Rollback -Monitored -ApplicationName fabric:/MyOwnAppName -ApplicationTypeVersion ""
        
        Get-ServiceFabricApplicationUpgrade fabric:/MyOwnAppName
        ```

    - Create:

        ```powershell
        New-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_Tenant -ApplicationTypeName "MyOwnAppType" -ApplicationTypeVersion "" -ApplicationParameter
        ```

## How to generate app params

Generate app params JSON:

```powershell
$params_pa = .\CreateAppParams.ps1 -ServiceBusConnectionString "[Connection string]" -ApplicationInsightsKey "[Application Insights key]"
```

Convert JSON to hashtable:

```powershell
(ConvertFrom-Json $params_pa).psobject.properties | Foreach { $hashtable_pa[$_.Name] = $_.Value }
```
