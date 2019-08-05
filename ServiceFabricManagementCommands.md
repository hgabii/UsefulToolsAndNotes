# Service Fabric Management Commands

### SF cluster connections:

#### Connect to cecloud-dev SF:
```shell
Connect-ServiceFabricCluster -ConnectionEndpoint "cecloud-dev.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "E9A9CA9194CDACC767E6E488433ECD94D357FE8C"
```

#### Connect to cecloud-test SF:
```shell
Connect-ServiceFabricCluster -ConnectionEndpoint "cecloud-test.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "8F16454A345A136A31C6A0146E0B3FDEF8AEEE73"
```

#### Connect to servicefabric-geolabs SF:
```shell
Connect-ServiceFabricCluster -ConnectionEndpoint "servicefabric-geolabs.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "CE204015AC977971DD9F60F0AFCA8570E1B9DB61"
```

#### Connect to buzzeasy-prod SF:
```shell
Connect-ServiceFabricCluster -ConnectionEndpoint "buzzeasy-prod.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "A8F0186668486C136DECF6FE4B80B8435D1B8754"
```

#### Connect to buzzplus-prod SF:
```shell
Connect-ServiceFabricCluster -ConnectionEndpoint "buzzplus-prod.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "424080AB9D61B5F145C5F97EAA8BB2E24753161A"
```

### Template commands:

#### New CloudCE application:
```shell
New-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_Tenant -ApplicationTypeName "CloudContactExpertType" -ApplicationTypeVersion "" -ApplicationParameter
```

#### New BuzzPlus application:
```shell
New-ServiceFabricApplication -ApplicationName fabric:/BuzzPlus_Tenant -ApplicationTypeName "BuzzPlusType" -ApplicationTypeVersion "" -ApplicationParameter 
```

#### Update CloudCE application:
```shell
Start-ServiceFabricApplicationUpgrade -UnmonitoredAuto -ApplicationName fabric:/CloudContactExpert_Tenant -ApplicationTypeVersion "" -ApplicationParameter
```

#### Update BuzzPlus application:
```shell
Start-ServiceFabricApplicationUpgrade -UnmonitoredAuto -ApplicationName fabric:/BuzzPlus_Tenant -ApplicationTypeVersion "" -ApplicationParameter
```

#### Remove CloudCE application:
```shell
Remove-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_Tenant
```

#### Remove BuzzPlus application:
```shell
Remove-ServiceFabricApplication -ApplicationName fabric:/BuzzPlus_Tenant
```

#### Force remove
```
Remove-ServiceFabricService -ServiceName fabric:/BuzzeasyChatDev/SmsConnector -ForceRemove
```

#### Create service
```
New-ServiceFabricService -Stateless -PartitionSchemeSingleton -ApplicationName fabric:/BuzzeasyChatDev -ServiceName fabric:/BuzzeasyChatDev/ApiCallerService -ServiceTypeName ApiCallerServiceType -InstanceCount 1 -DefaultMoveCost Zero -ServicePackageActivationMode ExclusiveProcess
```

## How to export cert
> NOTE: When import, check "be exportable"
```shell
[System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes("f:\CEDevelopment\Certs\cecloud-test-vault-cecloud-test-cert-20180504-with-pwd.pfx"))
```

## How to deploy SF application package

1. Copy the Application Package to the Image Store

CloudCE:
```shell
Copy-ServiceFabricApplicationPackage -ApplicationPackagePath "c:\ReposPrimary\CloudCE\Application\CloudContactExpert\pkg\Release" -ApplicationPackagePathInImageStore "CloudContactExpert\_GH"
```

BuzzPlus:
```shell
Copy-ServiceFabricApplicationPackage -ApplicationPackagePath "c:\ReposPrimary\BuzzPlus\Application\BuzzPlus\pkg\Release" -ApplicationPackagePathInImageStore "BuzzPlus\_GH"
```

2. Register Application Package

CloudCE:
```shell
Register-ServiceFabricApplicationType -ApplicationPathInImageStore "CloudContactExpert\_GH" -TimeoutSec 600
```

BuzzPlus:
```shell
Register-ServiceFabricApplicationType -ApplicationPathInImageStore "BuzzPlus\_GH" -TimeoutSec 600
```

3. Remove Application Package from Image Store

CloudCE:
```shell
Remove-ServiceFabricApplicationPackage -ApplicationPackagePathInImageStore "CloudContactExpert\_GH" -ImageStoreConnectionString fabric:ImageStore
```

BuzzPlus:
```shell
Remove-ServiceFabricApplicationPackage -ApplicationPackagePathInImageStore "BuzzPlus\_GH" -ImageStoreConnectionString fabric:ImageStore
```

4. Upgrade or create new Application

Update:
```shell
Start-ServiceFabricApplicationUpgrade -HealthCheckStableDurationSec 60 -UpgradeDomainTimeoutSec 1200 -UpgradeTimeout 3000 -FailureAction Rollback -Monitored -ApplicationName fabric:/CloudContactExpert_Tenant -ApplicationTypeVersion ""

Get-ServiceFabricApplicationUpgrade fabric:/CloudContactExpert_Tenant
```

Create:
```shell
New-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_Tenant -ApplicationTypeName "CloudContactExpertType" -ApplicationTypeVersion "" -ApplicationParameter
```

#### App params generation:

```
$params_pa = .\CreateAppParams.ps1 -environment Prod -customerName pademo -EnvironmentSubscriptionId 96cd3ac2-1b22-4639-9eaa-94f17c7854ca
-ServicePrincipalTenantId ddb0d7ac-52f1-403c-a926-9bca83caa4c1 -ServicePrincipalClientId 9f713010-7c41-4660-8097-1d0167f
c6d1e -ServicePrincipalPassword pwd= -DomainAddress cecloud-test.geomant.cloud -
BuzzeasyResourceGroupName buzzeasychat-tenant-cld1-prd-rg -BuzzeasyServiceBusNamespace buzzeasychatcld1sb -BuzzeasyOutbo
undQueueName cloudconnector_25_1 -BuzzeasyOutboundQueueSAS cloudconnector_25 -BuzzeasyInboundQueueName accqueuechat -Buz
zeasyInboundQueueSAS cloudconnector_25 -NotEncryptParams
```

```
(ConvertFrom-Json
$params_pa).psobject.properties | Foreach { $hashtable_pa[$_.Name] = $_.Value }
```

### Examles:

```
New-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_ghorvath -ApplicationTypeName "CloudContactExpertType" `
-ApplicationTypeVersion "1.0.0.4" `
-ApplicationParameter @{ServiceBusConnectionString='[Connection string specific for Generali]'; ApplicationInsightsKey='[Common Application Insights key to log CE messages with]'}
```
