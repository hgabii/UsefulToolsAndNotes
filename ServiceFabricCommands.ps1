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
New-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_ghorvath -ApplicationTypeName "CloudContactExpertType" -ApplicationTypeVersion "1.0.0.4" 
-ApplicationParameter @{ServiceBusConnectionString='[Connection string specific for Generali]'; ApplicationInsightsKey='[Common Application Insights key to log CE messages with]'}

New-ServiceFabricApplication -ApplicationName fabric:/BuzzPlus_Test -ApplicationTypeName "BuzzPlusType" -ApplicationTypeVersion "1.0.0.20180910.5" -ApplicationParameter

New-ServiceFabricApplication -ApplicationName fabric:/BuzzPlus_Test2 -ApplicationTypeName "BuzzPlusType" -ApplicationTypeVersion "1.0.0" -ApplicationParameter @{ServiceBusConnectionString='Endpoint=sb://buzzplus-dev-ns-test2.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=7J8IcSBAepTHN4L9JAwzzUd4RR+Nrj2Ke4t7f1slPI0='; ApplicationInsightsKey='123657a0-f337-4232-9bd6-2da2ac2a9ec7'; PublicAddressRoot='https://cecloud-test.geomant.cloud'; AgentFabricEndpointUrl='https://cecloud-test.geomant.cloud/BuzzPlus_Test2/BuzzPlusEngine/api/fabric/GetState'; AuthorizationServiceAuthority='https://geoauth-dev.azurewebsites.net'; AuthorizationServiceClientId='client.bp.cecloud-test.Tenant2'; AuthorizationServiceClientSecret='204df46d9ef94860b1c49b9193936d58'; AuthorizationServiceClientScope='bp.access'; AuthorizationServiceAudience='bp.access'; AuthorizationTokenEndpoint='https://geoauth-dev.azurewebsites.net/connect/token'; ChatProxy_PartitionCount='1'; ChatProxy_MinReplicaSetSize='3'; ChatProxy_TargetReplicaSetSize='3'; ServiceBusConnectionString_BuzzeasyIn='Endpoint=sb://buzzeasychatcld1sb.servicebus.windows.net/;SharedAccessKeyName=cloudconnector_3;SharedAccessKey=YqDwPeN7J0NU67QUG5pG3c0UftpxIJ8eNcfI82Xjm+A=;EntityPath=cloudconnector_3_1'; ServiceBusConnectionString_BuzzeasyOut='Endpoint=sb://buzzeasychatcld1sb.servicebus.windows.net/;SharedAccessKeyName=cloudconnector_3;SharedAccessKey=6Ns78OMR8IIaP8YcbHQXnN9mG24mkZ3Z9e0DCB8dU/g=;EntityPath=accqueuechat'; DocumentStoreService_InstanceCount='-1'; BlobStorageAccountName='docsdevtest2'; BlobStorageAccountKey='hAcZu+bWlyw8gQ/lPT09VqGRnbF7iSELnwBdI/BTA487xjWi/s2Twth0W6Zpheur4LGi+4TETjTSeaT5BUeLvw=='; BlobStorageContainerName='documentstoreservice-container-test2'; KeyVaultClientId='5b3d648a-6494-4f2a-8fa5-2282e512e5f6'; KeyVaultClientSecret='9DuwWg2azbqrMhkeoARx/wCGCYwTZQZ5W6ZT8rCqpCc='; KeyVaultRSAKeyIdentifier='https://sf-geolabs-vault.vault.azure.net/keys/storage-encryption-key/4ac8c9ec96c444ac83d10744c765c601'; AgentFrontEnd_InstanceCount='1'; NodeJsEnvironment='development'; BuzzPlusEngine_PartitionCount='1'; BuzzPlusEngine_MinReplicaSetSize='3'; BuzzPlusEngine_TargetReplicaSetSize='3'; ResourceHeartbeat_TimeoutSeconds='60'; ChatFrontEndUrl='https://cecloud-test.geomant.cloud/BuzzPlus_ChatConversationWindow_Test2/ChatFrontEnd/'; CQFrontEndUrl=''; ResourceMaxConcurrentWorkItems='3'; ExternalWorkAssignmentEngineUrl=''; AuthenticationEnabled='true'; }


Template for upgrading tenant:
Start-ServiceFabricApplicationUpgrade -ApplicationName fabric:/CloudContactExpert_Tenant -ApplicationTypeVersion "1.0.0.2" -UnmonitoredAuto 
-ApplicationParameter @{ServiceBusConnectionString='[Connection string specific for Generali]'; ApplicationInsightsKey='[Common Application Insights key to log CE messages with]'}

Template for delete SF application:
Remove-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert

### Export Cert ###
# When inport, check be exportable
[System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes("f:\CEDevelopment\Certs\cecloud-test-vault-cecloud-test-cert-20180504-with-pwd.pfx"))

# Deploy package #

Copy-ServiceFabricApplicationPackage -ApplicationPackagePath c:\ContactExpertRepo\CloudCE\Application\CloudContactExpert\pkg\Release -ApplicationPackagePathInImageStore "CloudContactExpert\_V2"
Copy-ServiceFabricApplicationPackage -ApplicationPackagePath c:\CESecondaryRepo\CloudCE\Application\CloudContactExpert\pkg\Release -ApplicationPackagePathInImageStore "CloudContactExpert\_V2"

Register-ServiceFabricApplicationType -ApplicationPathInImageStore "CloudContactExpert\_V2" -TimeoutSec 600

Remove-ServiceFabricApplicationPackage -ApplicationPackagePathInImageStore "CloudContactExpert\_V2" -ImageStoreConnectionString fabric:ImageStore

Start-ServiceFabricApplicationUpgrade -ApplicationName fabric:/CloudContactExpert -ApplicationTypeVersion 1.0.2 -HealthCheckStableDurationSec 60 -UpgradeDomainTimeoutSec 1200 -UpgradeTimeout 3000   -FailureAction Rollback -Monitored

Get-ServiceFabricApplicationUpgrade fabric:/CloudContactExpert

# App params generation #


$params_pa = .\Cre
ateAppParams.ps1 -environment Prod -customerName pademo -EnvironmentSubscriptionId 96cd3ac2-1b22-4639-9eaa-94f17c7854ca
-ServicePrincipalTenantId ddb0d7ac-52f1-403c-a926-9bca83caa4c1 -ServicePrincipalClientId 9f713010-7c41-4660-8097-1d0167f
c6d1e -ServicePrincipalPassword bqWhLZqqqDdDSOfJEBfa7SJc3Cw6n9QBxJYwAGEaJkY= -DomainAddress cecloud-test.geomant.cloud -
BuzzeasyResourceGroupName buzzeasychat-tenant-cld1-prd-rg -BuzzeasyServiceBusNamespace buzzeasychatcld1sb -BuzzeasyOutbo
undQueueName cloudconnector_25_1 -BuzzeasyOutboundQueueSAS cloudconnector_25 -BuzzeasyInboundQueueName accqueuechat -Buz
zeasyInboundQueueSAS cloudconnector_25 -NotEncryptParams


(ConvertFrom-Json
$params_pa).psobject.properties | Foreach { $hashtable_pa[$_.Name] = $_.Value }

### Application parameters ###

 # ghorvath #
-ApplicationParameter @{
ServiceBusConnectionString='Endpoint=sb://cecloud-dev-ns-ghorvath.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=L25+Yf0wqRdqN4q7QahImrXsr74cu7TXic38Sspm9fs='; 
ApplicationInsightsKey='ec727b7b-5d69-47bb-a022-2006e8f73302';
ServiceBusConnectionString_BuzzeasyIn='';
ServiceBusConnectionString_BuzzeasyOut=''; 
LoadBalancerPublicAddress='cecloud-dev.geomant.cloud';
BlobStorageAccountName='ceclouddevdocumentstore'; BlobStorageAccountKey='0nPKRb+j4Ddoh6+WrHrQXpBetFzDxpK3hDtjZgdAWk9QF8xkKbn7v6zg0AFAb0/nTNAISaHYuGCi7hzsKk9KXQ==';
BlobStorageContainerName='documentstoreservice-container-ghorvath'; 
KeyVaultClientId='9c3316e1-481a-45a3-9590-4a8cb786e024'; KeyVaultClientSecret='SG/Xh9f9iTq7fGEaFKAuv5jqQm9rFDaoOgipPFZ+1YA='; 
KeyVaultRSAKeyIdentifier='https://cecloud-dev-vault.vault.azure.net/keys/storage-encryption-key/cb54bd48cd8847f4829fa966eba597f8';
AuthorizationServiceDomain='https://geoauth-dev.azurewebsites.net';
AuthorizationServiceAudience='cechatagentapi';
AuthorizationServiceTokenEndpoint='https://geoauth-dev.azurewebsites.net/connect/token';
AuthorizationServiceClientId='ce_thin_client_service';
AuthorizationServiceClientSecret='byebyeinteractive';
AuthorizationServiceClientScope='cechatagentapi';
AuthorizationServiceHostName='geoauth-dev.azurewebsites.net';
AuthorizationServiceHostClientSecret='secret';
AgentFrontEnd_InstanceCount='1';
ChatProxy_PartitionCount='1';
ChatProxy_MinReplicaSetSize='1';
ChatProxy_TargetReplicaSetSize='1';
AgentChatBackEnd_PartitionCount='1';
AgentChatBackEnd_MinReplicaSetSize='1';
AgentChatBackEnd_TargetReplicaSetSize='1';
QueueStatusServiceBackEnd_PartitionCount='1';
QueueStatusServiceBackEnd_MinReplicaSetSize='1';
QueueStatusServiceBackEnd_TargetReplicaSetSize='1';
QueueStatusServiceFrontEnd_InstanceCount='1';
CallbackServiceBackEnd_PartitionCount='1';
CallbackServiceBackEnd_MinReplicaSetSize='1';
CallbackServiceBackEnd_TargetReplicaSetSize='1';
CallbackServiceFrontEnd_InstanceCount='1';
DocumentStoreService_InstanceCount='1';
IdentityProvider_PartitionCount='1';
IdentityProvider_MinReplicaSetSize='1';
IdentityProvider_TargetReplicaSetSize='1';
}

 # dev #
-ApplicationParameter @{ AgentFrontEnd_InstanceCount='-1'; ChatProxy_PartitionCount='1'; ChatProxy_MinReplicaSetSize='3'; ChatProxy_TargetReplicaSetSize='3'; AgentChatBackEnd_PartitionCount='1';
AgentChatBackEnd_MinReplicaSetSize='3'; AgentChatBackEnd_TargetReplicaSetSize='3'; QueueStatusServiceBackEnd_PartitionCount='1'; QueueStatusServiceBackEnd_MinReplicaSetSize='1';
QueueStatusServiceBackEnd_TargetReplicaSetSize='3'; QueueStatusServiceFrontEnd_InstanceCount='-1'; CallbackServiceBackEnd_PartitionCount='1'; CallbackServiceBackEnd_MinReplicaSetSize='1';
CallbackServiceBackEnd_TargetReplicaSetSize='3'; CallbackServiceFrontEnd_InstanceCount='-1'; DocumentStoreService_InstanceCount='-1'; IdentityProvider_PartitionCount='1';
IdentityProvider_MinReplicaSetSize='3'; IdentityProvider_TargetReplicaSetSize='3';
ServiceBusConnectionString='Endpoint=sb://cecloud-dev-ns-dev.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=vy5MBuP/hlb+xa311PrUO5OXkrzXLobGRMTIw9HM9q0=';
ApplicationInsightsKey='ec727b7b-5d69-47bb-a022-2006e8f73302';
ServiceBusConnectionString_BuzzeasyIn='Endpoint=sb://buzzeasychatdev1sb.servicebus.windows.net/;SharedAccessKeyName=cloudconnector1;SharedAccessKey=zmVmVOGZfnPbwmPvn/dejeDd7OmKqO6vh76OUCifuu0=;EntityPath=cloudconnector1';
ServiceBusConnectionString_BuzzeasyOut='Endpoint=sb://buzzeasychatdev1sb.servicebus.windows.net/;SharedAccessKeyName=cloudconnector1;SharedAccessKey=Za288EeEn4jS2PnXkR0PYPHrTKFhR7vfX9W0rckBhaA=;EntityPath=accqueuechat';
LoadBalancerPublicAddress='cecloud-dev.geomant.cloud';
BlobStorageAccountName='ceclouddevdocumentstore';
BlobStorageAccountKey='0nPKRb+j4Ddoh6+WrHrQXpBetFzDxpK3hDtjZgdAWk9QF8xkKbn7v6zg0AFAb0/nTNAISaHYuGCi7hzsKk9KXQ==';
BlobStorageContainerName='documentstoreservice-container-dev';
KeyVaultClientId='9c3316e1-481a-45a3-9590-4a8cb786e024';
KeyVaultClientSecret='SG/Xh9f9iTq7fGEaFKAuv5jqQm9rFDaoOgipPFZ+1YA=';
KeyVaultRSAKeyIdentifier='https://cecloud-dev-vault.vault.azure.net/keys/storage-encryption-key/cb54bd48cd8847f4829fa966eba597f8';
AuthorizationServiceDomain='https://geoauth-dev.azurewebsites.net';
AuthorizationServiceAudience='cechatagentapi';
AuthorizationServiceTokenEndpoint='https://geoauth-dev.azurewebsites.net/connect/token';
AuthorizationServiceClientId='ce_thin_client_service';
AuthorizationServiceClientSecret='byebyeinteractive';
AuthorizationServiceClientScope='cechatagentapi';
AuthorizationServiceHostName='geoauth-dev.azurewebsites.net';
AuthorizationServiceHostClientSecret='secret';
}

 # test2 #
-ApplicationParameter @{ AgentFrontEnd_InstanceCount='-1'; ChatProxy_PartitionCount='1'; ChatProxy_MinReplicaSetSize='3'; ChatProxy_TargetReplicaSetSize='3'; AgentChatBackEnd_PartitionCount='1';
AgentChatBackEnd_MinReplicaSetSize='3'; AgentChatBackEnd_TargetReplicaSetSize='3'; QueueStatusServiceBackEnd_PartitionCount='1'; QueueStatusServiceBackEnd_MinReplicaSetSize='1';
QueueStatusServiceBackEnd_TargetReplicaSetSize='3'; QueueStatusServiceFrontEnd_InstanceCount='-1'; CallbackServiceBackEnd_PartitionCount='1'; CallbackServiceBackEnd_MinReplicaSetSize='1';
CallbackServiceBackEnd_TargetReplicaSetSize='3'; CallbackServiceFrontEnd_InstanceCount='-1'; DocumentStoreService_InstanceCount='-1'; IdentityProvider_PartitionCount='1';
IdentityProvider_MinReplicaSetSize='3'; IdentityProvider_TargetReplicaSetSize='3';
ServiceBusConnectionString='Endpoint=sb://cecloud-test-ns-test2.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=QpMr7LXrPGyYfwAZrdtW/nC7lTFDqgMcNoymnpi7liA=';
ApplicationInsightsKey='123657a0-f337-4232-9bd6-2da2ac2a9ec7';
ServiceBusConnectionString_BuzzeasyIn='Endpoint=sb://buzzeasychatqasb.servicebus.windows.net/;SharedAccessKeyName=cloudconnector1;SharedAccessKey=A4XCmwgHmkVfCE9SI9JBTjRpSF4O0t1Kqu5VO8Y643A=;EntityPath=cloudconnector1';
ServiceBusConnectionString_BuzzeasyOut='Endpoint=sb://buzzeasychatqasb.servicebus.windows.net/;SharedAccessKeyName=cloudconnector1;SharedAccessKey=Qr5A6QWzjA81qqTBCIY77eHBJAqqcMxpA8NRe9z0Zc4=;EntityPath=accqueuechat';
LoadBalancerPublicAddress='cecloud-test.geomant.cloud';
BlobStorageAccountName='cecloudtestdocumentstore';
BlobStorageAccountKey='olnEX4mU8vQKuLd5BHw9nexwEKxMFBAhJmaFOztg1B/kKJGDKzqG12nuMK8pzsEGQeLcGaih7fmQvxz92XtHHw==';
BlobStorageContainerName='	documentstoreservice-container-test';
KeyVaultClientId='388aecca-3c2f-40ee-87cb-f9b535282f39';
KeyVaultClientSecret='	IdRfggBbtOZ9T3WDiDawGcw32dvX2Eris3g/sIUqoCs=';
KeyVaultRSAKeyIdentifier='https://cecloud-test-vault.vault.azure.net/keys/storage-encryption-key/534dd0f9aed745fdab92120dd62fc5c1';
AuthorizationServiceDomain='https://g-oauth.azurewebsites.net';
AuthorizationServiceAudience='ceaccess';
AuthorizationServiceTokenEndpoint='https://g-oauth.azurewebsites.net/connect/token';
AuthorizationServiceClientId='ce_client.cecloud-test.Tenant2';
AuthorizationServiceClientSecret='fa1ae37155f34611b1a605dd42f98633';
AuthorizationServiceClientScope='ceaccess';
AuthorizationServiceHostName='g-oauth.azurewebsites.net';
AuthorizationServiceHostClientSecret='7b3cd0accd494697bb8fa4a74a68adb7';
}
