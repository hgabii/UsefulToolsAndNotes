param (
	[Parameter(Mandatory=$true)][string]$AppName
)

$nodes = Get-ServiceFabricNode

foreach ($node in $nodes)
{
    $replicas = Get-ServiceFabricDeployedReplica -NodeName $node.NodeName -ApplicationName $AppName

    foreach ($replica in $replicas)
    {
        Remove-ServiceFabricReplica -ForceRemove -NodeName $node.NodeName -PartitionId $replica.PartitionId -ReplicaOrInstanceId $replica.ReplicaOrInstanceId
    }
}