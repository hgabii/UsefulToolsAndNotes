# Define the base URL and API key
$baseUrl = 'http://freepbx2.geolabs.com:8088/ari/bridges/{bridgeId}?api_key=ghorvath_test:K1skop1'

# Sample JSON array of strings
$jsonArray = '[
    "01e432c1e54f4dd59a63a49cb800bb6c",
    "06485dd65ed3457496914eab816bf6c6",
    "082e587a92984ed68f0810d4ab5ab879",
    "0c2a6f232ab945109302d5817e710ade",
    "19a9c2ef57d6440481b0e15aab1164af",
    "1debe0725eaa4b3085f6b56511ed5633",
    "229c5168da6440fe88dfb3bbfb217b91",
    "3d4276e9f4604b77995189d42c89454e",
    "50859e823caa4f0cb0403871eadc8426",
    "543b18443d174b29a7da932ca3586e71",
    "6155b59990444d0cace54e9c126cd416",
    "6263090adf88480c8511fd424c19539f",
    "7106ea5c81dc4333b5015140e831554f",
    "72bd8d369c9a44469274d4bdeb22080f",
    "8221e6d9980542b68f7713620cb7496d",
    "8634699c5b814588b0947370c71e2165",
    "8adabdeed727422980c8b5d9f4c2ef0f",
    "8e0362a9c1cb4be19c187f0a3f6fa744",
    "9d89194076f64df7b43f97e0480c5ee8",
    "a05fb5cb89c0441e8162d90a553dad60",
    "a95ccb29a99641468961cbabbce030ff",
    "b1cb6927541d43679c156f56aac9b916",
    "b3dfa2386b7044318b0d8c818095f61c",
    "b40c265033a6452c9846751f827f5913",
    "bc9d372964554c6fbafd51270c35f90a",
    "c240e30250e94323a11e9b4f4d8549fe",
    "c3c7df1cea5a478d97643d8a797e97ec",
    "d1147e67f68c4265a8bbb5aeb4e6a754",
    "d795a87899ac41de802c8554d7077f30",
    "ee49a23d206348c882ea03f1c22cab00",
    "fc1f6931cb67494aa42aa9f33f5201a7",
    "owcon-11-0b24c56dc6114464b8ddcf95f71ba210",
    "owcon-11-33a7831e245342db97695db0334cf1f8",
    "owcon-11-9f4d5cadba7c420f8621815029688a13",
    "owcon-11-ad27d3f07b834ce8a286062754336bd0",
    "owcon-11-bd31cd5f68614c4b85d5a3b6c2ee9b72",
    "owcon-11-be281a30bebb4f339c1836d49d2e6828",
    "owcon-11-e6cd2224e43c462da440bbed6805456e",
    "owcon-11-f53f299104614b75a807c8f89b81795f",
    "owcon-11-f6173acd82824429a08cc642a67fc632"
  ]'

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
