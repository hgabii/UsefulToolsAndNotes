### Connections ###

Connect to cecloud-dev SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "cecloud-dev.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "E9A9CA9194CDACC767E6E488433ECD94D357FE8C"

Connect to cecloud-test SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "cecloud-test.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "8B441B37D0BA308B591D933FEF8E199AF207ABF5"

Connect to servicefabric-geolabs SF:
Connect-ServiceFabricCluster -ConnectionEndpoint "servicefabric-geolabs.westeurope.cloudapp.azure.com:19000" -AzureActiveDirectory -ServerCertThumbprint "CE204015AC977971DD9F60F0AFCA8570E1B9DB61"

### Templates ###

Template for Deploying new tenant:
New-ServiceFabricApplication -ApplicationName fabric:/CloudContactExpert_ghorvath -ApplicationTypeName "CloudContactExpertType" -ApplicationTypeVersion "1.0.0.4" 
-ApplicationParameter @{ServiceBusConnectionString='[Connection string specific for Generali]'; ApplicationInsightsKey='[Common Application Insights key to log CE messages with]'}

New-ServiceFabricApplication -ApplicationName fabric:/BuzzPlus_Test -ApplicationTypeName "BuzzPlusType" -ApplicationTypeVersion "1.0.0.20180910.5" 
-ApplicationParameter

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
