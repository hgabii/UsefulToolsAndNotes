# Define the base URL and API key
$baseUrl = 'http://[ASTERISK_URL]:8088/ari/bridges/{bridgeId}?api_key=[MY_ARI_USERNAME:MY_ARI_PASSWORD]'

# Sample JSON array of strings
$jsonArray = '[
    "01e432c1e54f4dd59a63a49cb800bb6c",
    "06485dd65ed3457496914eab816bf6c6",
    "082e587a92984ed68f0810d4ab5ab879"]'

# Convert the JSON array to a PowerShell array
$bridges = $jsonArray | ConvertFrom-Json

# Iterate through each bridge and make the REST DELETE call
foreach ($bridge in $bridges) {
    # Replace {bridgeId} with the current bridge in the URL
    $url = $baseUrl -replace '{bridgeId}', $bridge

    # Make the REST DELETE call
    try {
        Invoke-RestMethod -Uri $url -Method Delete
        Write-Host "DELETE request sent for bridge '$bridge'"
    }
    catch {
        Write-Host "Failed to send DELETE request for bridge '$bridge': $_"
    }
}
