# Define the base URL and API key
$baseUrl = 'http://[ASTERISK_URL]:8088/ari/channels/{channelId}?api_key=[MY_ARI_USERNAME:MY_ARI_PASSWORD]'

# Sample JSON array of strings
$jsonArray = '[
"1683650473.175397",
"1683650474.175398",
"1683650482.175433",
"1683727848.192391",
"1683727859.192402"]'

# Convert the JSON array to a PowerShell array
$channels = $jsonArray | ConvertFrom-Json

# Iterate through each channel and make the REST DELETE call
foreach ($channel in $channels) {
    # Replace {channelId} with the current channel in the URL
    $url = $baseUrl -replace '{channelId}', $channel

    # Make the REST DELETE call
    try {
        Invoke-RestMethod -Uri $url -Method Delete
        Write-Host "DELETE request sent for channel '$channel'"
    }
    catch {
        Write-Host "Failed to send DELETE request for channel '$channel': $_"
    }
}
