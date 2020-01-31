# SfB related guides

## How to issue new cert for SfB trusted application

MS documentation: [https://docs.microsoft.com/en-us/skype-sdk/ucma/activating-an-auto-provisioned-application](https://docs.microsoft.com/en-us/skype-sdk/ucma/activating-an-auto-provisioned-application)

CE guide: [https://docs.geomant.com/ce/7.0/Configuring_CE_Certificates.html?q=Certificate](https://docs.geomant.com/ce/7.0/Configuring_CE_Certificates.html?q=Certificate)

## How to register new SfB endpoint

- Login to one of the front-end pool
- Search for the application:

    ```powershell
    Get-CsTrustedApplication > C:/Temp/endpont.txt
    ```
 
- Create new endpoint:

    ```powershell
    New-CsTrustedApplicationEndpoint  -ApplicationId {appId} -TrustedApplicationFqdn {ivrpool01.sdudev.loca} -SipAddress {sip:sdu_dev_ivr_ep_3@sdudev.local} -DisplayName {NameWhatIsItUsedFor}
    ```
