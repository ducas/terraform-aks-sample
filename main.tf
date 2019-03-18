terraform {}

variable "cluster_name" {}
variable "resource_group_name" {}
variable "default_node_count" {}

provider "external" {}

data "external" "aks_cluster" {
  program = ["pwsh", "Get-AksNodeCount.ps1"]

  query = {
    cluster_name        = "${var.cluster_name}"
    resource_group_name = "${var.resource_group_name}"
    default_node_count  = "${var.default_node_count}"
  }
}

output "count" {
  value = "${data.external.aks_cluster.result.node_count}"
}
