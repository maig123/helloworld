# Provides the required a network, subnet for the GKE Module
# Creates: 
#  - vpc
#  - subnets - ip ranges are used for k8s networks 


resource "google_compute_network" "hellovpc" {
    name = var.network
    auto_create_subnetworks = "false" 
}

resource "google_compute_subnetwork" "hellosubnet" {
  name = var.subnetwork
  region = var.region
  network = var.network
  ip_cidr_range = var.ip_subnet_range

    
  secondary_ip_range {
    range_name = var.pod_range
    ip_cidr_range = var.ip_pod

  }
  secondary_ip_range {
    range_name = var.service_range 
    ip_cidr_range = var.ip_service 
  }

  depends_on = [google_compute_network.hellovpc]
  
}

