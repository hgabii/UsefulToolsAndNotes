## Login
Login-AzureRmAccount

##Set variable
$environmentName="cecloud-dev"

## Get secret or cert value
$cert= Get-AzureKeyVaultSecret  -VaultName "$($environmentName)-vault" -Name "$($environmentName)-cert"

## Import secret or cert
Import-AzureKeyVaultCertificate -VaultName "$($environmentName)-secure-vault" -Name "$($environmentName)-cert" -CertificateString $cert.SecretValueText

## Test deployment
Test-AzureRmResourceGroupDeployment -ResourceGroupName <Resource Group that your cluster is currently deployed to> -TemplateFile <PathToTemplate>

## Set subscription
Set-AzureRmContext -SubscriptionId "96cd3ac2-1b22-4639-9eaa-94f17c7854ca"

Set-AzureRmContext -SubscriptionId "d72e216a-2068-4b52-b4a8-7c8eb2bb1dea"

##
New-AzureRmResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName ExampleResourceGroup `
  -TemplateFile c:\MyTemplates\storage.json `
  -TemplateParameterFile c:\MyTemplates\storage.parameters.json
  
  
New-AzureRmDeployment -Location "West Europe" -TemplateFile "c:\ContactExpertRepo\BuzzPlus\Infrastructure\BuzzPlusInfrastructure\BuzzPlusResourcesARM\BuzzPlusResources.json" 
-TemplateParameterFile "c:\ContactExpertRepo\BuzzPlus\Infrastructure\BuzzPlusInfrastructure\BuzzPlusResourcesARM\BuzzPlusResources.BE.json"

