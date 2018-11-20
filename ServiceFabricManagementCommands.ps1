### Connections ###

Connect to cecloud-dev SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "cecloud-dev.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "E9A9CA9194CDACC767E6E488433ECD94D357FE8C"

Connect to cecloud-test SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "cecloud-test.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "8B441B37D0BA308B591D933FEF8E199AF207ABF5"

Connect to servicefabric-geolabs SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "servicefabric-geolabs.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "CE204015AC977971DD9F60F0AFCA8570E1B9DB61"

Connect to buzzeasy-prod SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "buzzeasy-prod.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "A8F0186668486C136DECF6FE4B80B8435D1B8754"

Connect to buzzplus-prod SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "buzzplus-prod.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "424080AB9D61B5F145C5F97EAA8BB2E24753161A"

### Templates ###

Template for Deploying new tenant:
New-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_ghorvath -ApplicationTypeName "CloudContactExpertType" -ApplicationTypeVersion "1.0.0.4" `
-ApplicationParameter @{ServiceBusConnectionString='[Connection string specific for Generali]'; ApplicationInsightsKey='[Common Application Insights key to log CE messages with]'}

New-ServiceFabricApplication -ApplicationName fabric:/BuzzPlus_Test -ApplicationTypeName "BuzzPlusType" -ApplicationTypeVersion "1.0.0.20180910.5" -ApplicationParameter

Template for upgrading tenant:
Start-ServiceFabricApplicationUpgrade -ApplicationName fabric:/CloudContactExpert_Tenant -ApplicationTypeVersion "1.0.0.2" -UnmonitoredAuto 
-ApplicationParameter @{ServiceBusConnectionString='[Connection string specific for Generali]'; ApplicationInsightsKey='[Common Application Insights key to log CE messages with]'}

Template for delete SF application:
Remove-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert

### Export Cert ###
# When import, check "be exportable"
[System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes("f:\CEDevelopment\Certs\cecloud-test-vault-cecloud-test-cert-20180504-with-pwd.pfx"))

# Deploy package #

Copy-ServiceFabricApplicationPackage -ApplicationPackagePath c:\ContactExpertRepo\CloudCE\Application\CloudContactExpert\pkg\Release -ApplicationPackagePathInImageStore "CloudContactExpert\_V2"
Copy-ServiceFabricApplicationPackage -ApplicationPackagePath c:\CESecondaryRepo\CloudCE\Application\CloudContactExpert\pkg\Release -ApplicationPackagePathInImageStore "CloudContactExpert\_V2"

Register-ServiceFabricApplicationType -ApplicationPathInImageStore "CloudContactExpert\_V2" -TimeoutSec 600

Remove-ServiceFabricApplicationPackage -ApplicationPackagePathInImageStore "CloudContactExpert\_V2" -ImageStoreConnectionString fabric:ImageStore

Start-ServiceFabricApplicationUpgrade -ApplicationName fabric:/CloudContactExpert -ApplicationTypeVersion 1.0.2 -HealthCheckStableDurationSec 60 -UpgradeDomainTimeoutSec 1200 -UpgradeTimeout 3000   -FailureAction Rollback -Monitored

Get-ServiceFabricApplicationUpgrade fabric:/CloudContactExpert

# App params generation #

$params_pa = .\CreateAppParams.ps1 -environment Prod -customerName pademo -EnvironmentSubscriptionId 96cd3ac2-1b22-4639-9eaa-94f17c7854ca
-ServicePrincipalTenantId ddb0d7ac-52f1-403c-a926-9bca83caa4c1 -ServicePrincipalClientId 9f713010-7c41-4660-8097-1d0167f
c6d1e -ServicePrincipalPassword pwd= -DomainAddress cecloud-test.geomant.cloud -
BuzzeasyResourceGroupName buzzeasychat-tenant-cld1-prd-rg -BuzzeasyServiceBusNamespace buzzeasychatcld1sb -BuzzeasyOutbo
undQueueName cloudconnector_25_1 -BuzzeasyOutboundQueueSAS cloudconnector_25 -BuzzeasyInboundQueueName accqueuechat -Buz
zeasyInboundQueueSAS cloudconnector_25 -NotEncryptParams

(ConvertFrom-Json
$params_pa).psobject.properties | Foreach { $hashtable_pa[$_.Name] = $_.Value }

