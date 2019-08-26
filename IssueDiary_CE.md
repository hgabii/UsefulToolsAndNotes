TEMPLATE:

- TITLE: 
- VERSION:
- REPORTED BY:
- REPORT TIME:
- ISSUE NUMBER:
- SYMPTOMS:
- ANALYSES:
- SOLUTION:

---

### Contact Expert ###

#1
- TITLE: Wrong SfB statuses in the SfB client
- VERSION : x
- REPORTED BY: own
- REPORT TIME: 2017.06.01
- ISSUE NUMBER: x
- TITLE: Wrong SfB statuses in the SfB client
- VERSION : x
- REPORTED BY: own
- REPORT TIME: 2017.06.01

#2
- TITLE: Agent Login - Invalid credentials are specified
- VERSION: 6.1
- REPORTED BY: own
- REPORT TIME: 2019.02.06
- ISSUE NUMBER: x
- SYMPTOMS: Agent can not login. Login failed: Invalid credentials are specified. Username: ghorvath@sdudev.local,
Server: http://sdudevcelync3.sdudev.local:8080/ClientAccessServer
- ANALYSES: Wrong HA peers in the config file.
- SOLUTION: C:\Users\username\AppData\Roaming\CEHAPeers.xml set the active server.

#3
- TITLE: Agent Application - Script panel sometimes stay hidden (#13226)
- VERSION: 5.10
- REPORTED BY: BISZ
- REPORT TIME: 2018.10.02
- ISSUE NUMBER: x
- SYMPTOMS: Script panel does not show up when a call comes in.
- ANALYSES: Contact swap page was loaded. In that case we can not show the script. The agent did not clicked the refresh button, when the swap ended.
- SOLUTION: Not a bug!


#5
- TITLE: ManagementService - Real-time reports not working 
- VERSION: 5.8
- REPORTED BY: AccentHousing (jbabai)
- REPORT TIME: 2019.02.26
- ISSUE NUMBER: x
- SYMPTOMS: DRSite present. The stat server is on another server. The real time reports are not showing any data.
- ANALYSES: In this setup the stat server can run only on one machine. 
- SOLUTION: Stop the other stat servers.

#6
- TITLE: AgentApplication - Wrong username, pasword or skill assignment
- VERSION: x
- REPORTED BY: own
- REPORT TIME: 
- ISSUE NUMBER: x
- SYMPTOMS: "Wrong username, pasword or skill assignment" message displayed when try to login.
- ANALYSES: ...
- SOLUTION: C:\Users\username\AppData\Roaming\CEHAPeers.xml set the active server

#7
- TITLE: Installation - Invalid cert
- VERSION: x
- REPORTED BY: own
- REPORT TIME:
- ISSUE NUMBER: x
- SYMPTOMS: Invalid certificate for CE.
- ANALYSES: No valid certificate installed.
- SOLUTION: How to generate cert:
	http://kb.geomant.com/display/CE510/Configuring+CE+Certificates
	http://kb.geomant.com/display/CE510/High+Availability+Options+for+Contact+Expert
	
#8
- TITLE: Outbound call not ringing and queue not get the call
- VERSION:
- REPORTED BY:
- REPORT TIME:
- ISSUE NUMBER:
- SYMPTOMS: Wrong certificate (different cert needed in case of HA)
- ANALYSES:
- SOLUTION: Issue new cert. http://kb.geomant.com/display/CE510/High+Availability+Options+for+Contact+Expert
	
#9
- TITLE: Installation - Can not get a cert. Server is out of domain.
- VERSION: x
- REPORTED BY: own
- REPORT TIME:
- ISSUE NUMBER: x
- SYMPTOMS: After restore a VM snapshot, the server is out of domain.
- ANALYSES:
- SOLUTION: Server is out of the domain
		tip: cmd -> netdom resetpwd /s:sdudev.local /ud:Administrator /pd:K1skop1
		
#10
- TITLE: Agent wallboard not working ("agent cannot be found")
- VERSION: x
- REPORTED BY: own
- REPORT TIME:
- ISSUE NUMBER: x
- SYMPTOMS:
- ANALYSES:
- SOLUTION: Windows authentication - The Identity of CEAgentAppPool was bad
		http://kb.geomant.com/display/kb/How+to+enable+Windows+Authentication+for+Contact+Expert+Part+II+-+CE+Agent+Client+Dashboard
		
#11
- TITLE: WebChat - Interaction not answered
- VERSION:
- REPORTED BY:
- REPORT TIME:
- ISSUE NUMBER:
- SYMPTOMS:
- ANALYSES:
- SOLUTION: Wrong entry point were defined for the chat campaign. 
		In Chat config the fwdn_chat1@sdudev.local, but for campaign a basic fqdn_campaign1@sdudev.local will be good.

#12
- TITLE: WebChat - server can not get the message
- VERSION:
- REPORTED BY:
- REPORT TIME:
- ISSUE NUMBER:
- SYMPTOMS:
- ANALYSES:
- SOLUTION: Need to add CEEndpointService to firewall rule (restart required)

#13
- TITLE: Installation - Something with database
- VERSION:
- REPORTED BY:
- REPORT TIME:
- ISSUE NUMBER:
- SYMPTOMS:
- ANALYSES:
- SOLUTION: Only the instance or port required (one of them) the default 1433

#14
- TITLE: Email attachments not displayed
- VERSION: 6.1
- REPORTED BY: AccentHousing (jbabai)
- REPORT TIME: 2019.08.10
- ISSUE NUMBER: #19100
- SYMPTOMS: Attachments not displayed, however the email contains attachments.
- ANALYSES: Content-type of the attachment is application/octet-stream and the Content-Disposition "header" is empty. The attachment is corrupted.
- SOLUTION: Display corrupted attachments.


