param (
	[Parameter(Mandatory=$true)][string]$certName,
	[Parameter(Mandatory=$true)][string]$certPwd,
	[Parameter(Mandatory=$true)][string]$vaultName,
	[Parameter(Mandatory=$true)][string]$certPath
)

### Log into Azure
Add-AzureRmAccount

# Upload Certificate to Azure's Key Vault
$securepfxpwd = ConvertTo-SecureString –String $certPwd –AsPlainText –Force # Password for the private key PFX certificate
Import-AzureKeyVaultCertificate -VaultName $vaultName -Name $certName -FilePath $certPath -Password $securepfxpwd