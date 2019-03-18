
$jsonPayload = [Console]::In.ReadLine()
$json = ConvertFrom-Json $jsonPayload
$nodeCount = $json.default_node_count

$aks = Get-AzAks -Name $json.cluster_name -ResourceGroupName $json.resource_group_name -ErrorAction SilentlyContinue

if ( $aks -ne $null ) {
    $nodeCount = $aks.AgentPoolProfiles[0].Count
}

Write-Output "{""node_count"":""$nodeCount""}"
