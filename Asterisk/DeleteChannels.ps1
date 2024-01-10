# Define the base URL and API key
$baseUrl = 'http://freepbx2.geolabs.com:8088/ari/channels/{channelId}?api_key=ghorvath_test:K1skop1'

# Sample JSON array of strings
$jsonArray = '[
"1683650473.175397",
"1683650474.175398",
"1683650482.175433",
"1683727848.192391",
"1683727859.192402",
"1683727865.192410",
"1683727868.192427",
"1684510091.319705",
"1684510093.319706",
"agent-11-da7ba1c25c1449009227b10d152bb203",
"agt-11-3706df4ef86b47f7a75b2bb8447154db",
"agt-11-4ec70d51af3d4c2694206cf2436b941b",
"agt-11-ceb101adf7924f4a87880d6e6de7e5b0",
"agt-11-ebcefa4a9037483f8142178077af26d0"]'

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
