param (
	[Parameter(Mandatory=$true)][string]$file
)

if (Test-Path $file)
{
    [xml]$appParamsXml = Get-Content $file

    $parameters = $appParamsXml.Application.Parameters.Parameter

    $result = "@{"

    For($i = 0; $i -lt $parameters.Length; $i++)
    {
        $result += "$($parameters[$i].Name)='$($parameters[$i].Value)'; "
    }

    $result += "}"

    Write-Host $result
}
else
{
    Write-Host "Wrong file path"
}