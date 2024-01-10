# Stateful Service Tests

$ConnectArgs = @{  ConnectionEndpoint = '[Service Fabric client connection endpoint]';  X509Credential = $True;  StoreLocation = 'CurrentUser';  StoreName = "MY";  ServerCommonName = "mycluster.cloudapp.net";  FindType = 'FindByThumbprint';  FindValue = "[Certificate thumbprint]"; 'ServerCertThumbprint' = "[Server certificate thumbprint]" }

Connect-ServiceFabricCluster @ConnectArgs

$ServiceName = "fabric:/AppName/ServiceName"

# Test A: moving the primary replica of the specified service to another node.
#
# Purpose: to verify that the original primary replica releases resources (e.g. Service Bus subscriptions)
# when exiting from RunAsynch() and the new primary replica starts using those resources as expected when 
# entering RunAsync(). Moreover, this test verifies that the new primary replica on the new node starts 
# processing new incoming requests correctly.
#
# Expected Behaviour: the specified serice works again as expected after the primary replica is 
# moved to the new node.

Move-ServiceFabricPrimaryReplica -ServiceName $ServiceName

# Test B: restarting the primary replica of the specified service.
#
# Purpose: to verify that the original primary replica releases resources, shuts down and then starts up as expected.
# This test also verifies that new incoming requests are started to be processed as expected by the new primary 
# replica on the new node when entering to RunAsync().
#
# Expected Behaviour: the specified serice works again as expected after the primary replica is 
# moved to the new node.

Restart-ServiceFabricReplica -ReplicaKindPrimary -PartitionKindSingleton -ServiceName $ServiceName

# Test C: performing complex fault scenarios (restarting replica, removing replica, moving primary replica,
# restarting partition etc) on the specified service.
#
# Purpose: to verify that the specified service automatically recovers after a more complex sequence of 
# platform and infrastructure related faults in injected.
#
# Expected Behaviour: the specified serice starts working again as expected after the test finished.

Invoke-ServiceFabricFailoverTestScenario -TimeToRunMinute 10 -MaxServiceStabilizationTimeoutSec 180 -WaitTimeBetweenFaultsSec 30 -ServiceName $ServiceName -PartitionKindSingleton

# Test D: performing chaos test on the entire cluster.
#
# Purpose: to verify that the each application hosted on the cluster recovers automatically after a 
# complex sequence of infrastructure related faults is injected.
#
# Expected Behaviour: each application hosted on the cluster starts working again as expected after the chaos 
# test finished.

$clusterHealthPolicy = New-Object -TypeName System.Fabric.Health.ClusterHealthPolicy
$clusterHealthPolicy.MaxPercentUnhealthyNodes = 10
$clusterHealthPolicy.MaxPercentUnhealthyApplications = 20
$clusterHealthPolicy.ConsiderWarningAsError = $False

Start-ServiceFabricChaos -TimeToRunMinute 15 -MaxConcurrentFaults 3 -MaxClusterStabilizationTimeoutSec 60 -WaitTimeBetweenIterationsSec 30 -WaitTimeBetweenFaultsSec 5 -EnableMoveReplicaFaults -ClusterHealthPolicy $clusterHealthPolicy
