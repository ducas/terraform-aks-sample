terraform {}

provider "external" {}
provider "azurerm" {}

variable "resource_group_name" {}
variable "resource_group_location" {}
variable "service_principal_client_id" {}
variable "service_principal_client_secret" {}
variable "cluster_name" {}
variable "kubernetes_version" {}
variable "default_node_count" {}
variable "node_vm_size" {}
variable "max_pods" {}
variable "vnet_subnet_id" {}
variable "log_analytics_workspace_id" {}

data "external" "aks_cluster" {
  program = ["pwsh", "Get-AksNodeCount.ps1"]

  query = {
    cluster_name        = "${var.cluster_name}"
    resource_group_name = "${var.resource_group_name}"
    default_node_count  = "${var.default_node_count}"
  }
}

resource "azurerm_kubernetes_cluster" "test" {
  name                = "${var.cluster_name}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
  dns_prefix          = "${var.cluster_name}"
  kubernetes_version  = "${var.kubernetes_version}"

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "${var.node_vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id  = "${var.vnet_subnet_id}"
    max_pods        = "${var.max_pods}"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = "${var.log_analytics_workspace_id}"
    }
  }

  service_principal {
    client_id     = "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_client_secret}"
  }

  network_profile {
    network_plugin = "kubenet"
  }

  lifecycle {
    prevent_destroy = false
  }
}
