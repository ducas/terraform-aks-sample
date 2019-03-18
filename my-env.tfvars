
resource_group_name = "my-resource-group"
resource_group_location = "australiaeast"

service_principal_client_id = "00000000-0000-0000-0000-000000000000"
service_principal_client_secret = "00000000000000000000000000000000"

cluster_name = "my-aks-cluster-1"
kubernetes_version = "1.11.7"
default_node_count = "4"
node_vm_size = "Standard_D1_v2"
max_pods = 100
vnet_subnet_id = "/subscriptions/[my-subscription-id]/resourceGroups/[my-subnet-rg]/providers/Microsoft.Network/virtualNetworks/[my-vnet-name]/subnets/[my-subnet-name]"

log_analytics_workspace_id = "/subscriptions/[my-subscription-id]/resourcegroups/[my-log-analytics-rg]/providers/microsoft.operationalinsights/workspaces/[my-workspace-name]"
