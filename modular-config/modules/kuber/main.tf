/*KUBERNETES-INFASTRUCTURE*/

#Kubernetes-Provider
/*
provider "kubernetes" {
  config_path = "~/.kube/config"
}
*/
#>>>

#Service-Layer-Controls
resource "google_container_cluster" "fleet-1" {
  name     = var.kube.fleet_name
  location = var.kube.subnet_region

  networking_mode = "VPC_NATIVE" #Specifies the default networking mode for the cluster
    network       = var.kube.net_name
    subnetwork    = var.kube.subnet_name

  remove_default_node_pool = true
    initial_node_count = 1

  release_channel {
    channel = "REGULAR" # (RAPID,REGULAR,STABLE) specifies how Frequently the cluster will be updated
  }
#>>>
  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-axii"
    services_secondary_range_name = "service-vesimir"
  }
#>>>  
  network_policy {
    provider = "PROVIDER_UNSPECIFIED"
    enabled  = true
  }
#>>>
  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
  deletion_protection = false #Don't Forget this so you can tear down.
}
#>>>>>

#Node-Pools
resource "google_container_node_pool" "node-pool-1" {
  name       = var.kube.pool_name
  location   = var.kube.subnet_region
  cluster    = var.kube.fleet_name
  node_count = 1

  autoscaling {
    min_node_count = var.kube.min_count
    max_node_count = var.kube.max_count
  }
  management {
    auto_repair  = true
    auto_upgrade = true
  }
  #>>>>>
    node_config {     
    machine_type    = "e2-medium" 
    labels = {
      role = "sardaukar"
    }
    service_account = "876288284083-compute@developer.gserviceaccount.com"#
    oauth_scopes    = [ # Defines outside services which can help manage cluster at extra cost:
      /*"https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",*/
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [google_container_cluster.fleet-1]
}
#>>>>>