TEMPLATE:

- PRODUCT AND VERSION:
- TITLE: 
- REPORTED BY:
- REPORT TIME:
- SYMPTOMS:
- ANALYSES:
- SOLUTION:

### ### ### ###

### Contact Expert ###

#1
- PRODUCT AND VERSION: Contact Expert x
- TITLE: Wrong SfB statuses in the SfB client
- REPORTED BY: own
- REPORT TIME: 2017.06.01
- SYMPTOMS: The agent does not see the custom CE statuses in the SfB client
- ANALYSES: The ace_presence.xml path is wrong
- SOLUTION: Set the custom state URL. 
	(regedit -> HKEY_LOCALMACHINE -> SOFTWARE -> Policies -> Microsoft -> Office -> 15.0/16.0 -> Lync -> CustomStateURL)

### BuzzPlus ###

### Azure ###

### Service Fabric ###

## draft ##

Contact Expert Installation:

- Problem: Something with database
	Solution: Only the instance or port required (one of them) the default 1433

- Problem: Outbound call not ringing and queue not get the call
	Solution: Wrong certificate (different cert needed in case of HA)
	
- Problem: WebChat - server can not get the message
	Solution: Need to add CEEndpointService to firewall rule (restart required)

- Problem: WebChat - Interaction not answered
	Solution: Wrong entry point were defined for the chat campaign. 
		In Chat config the fwdn_chat1@sdudev.local, but for campaign a basic fqdn_campaign1@sdudev.local will be good.
		
- Problem: Can not get a cert
	Solution: Server is out of the domain
		tip: cmd -> netdom resetpwd /s:sdudev.local /ud:Administrator /pd:K1skop1

- Problem: Agent wallboard not working ("agent cannot be found")
	Solution: Windows authentication - The Identity of CEAgentAppPool was bad
		http://kb.geomant.com/display/kb/How+to+enable+Windows+Authentication+for+Contact+Expert+Part+II+-+CE+Agent+Client+Dashboard

- How to generate cert:
	http://kb.geomant.com/display/CE510/Configuring+CE+Certificates
	http://kb.geomant.com/display/CE510/High+Availability+Options+for+Contact+Expert

Agent Application:

- Problem: Sfb statuses wrong
	Solution: regedit -> HKEY_LOCALMACHINE -> SOFTWARE -> Policies -> Microsoft -> Office -> .. -> CustomStateURL
	
- Problem: Wrong username, pasword or skill assignment
	Solution: C:\Users\username\AppData\Roaming\CEHAPeers.xml set the active server

##