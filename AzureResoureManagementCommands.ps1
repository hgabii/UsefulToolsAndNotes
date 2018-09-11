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
