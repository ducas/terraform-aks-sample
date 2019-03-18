# Terraform - AKS

Sample repo for working with AKS from Terraform.

## Getting the node count

If you have cluster autoscaler enabled, you don't exactly want a `terraform apply` to tear nodes down. Instead, you probably want to know how many nodes are currently in the cluster and apply with the same count. By using the external provider, we can run powershell to get this count.

The following code from `main.tf` invokes a powershell script to get the current node count while specifying a default count to return if the cluster does not exist -

    data "external" "aks_cluster" {
      program = ["pwsh", "Get-AksNodeCount.ps1"]
      query = {
        cluster_name        = "${var.cluster_name}"
        resource_group_name = "${var.resource_group_name}"
        default_node_count  = "${var.default_node_count}"
      }
    }
