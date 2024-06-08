# use the gke module to build a basic gke cluster.  
# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest


data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

resource "google_container_cluster" "default" {
  name               = "gke-standard-zonal-single-zone"
  location           = "us-east1-b"
  initial_node_count = 1

  # Set `deletion_protection` to `true` will ensure that one cannot
  # accidentally delete this instance by use of Terraform.
  deletion_protection = false
  network=var.network
  subnetwork = var.subnetwork
  ip_allocation_policy {
    cluster_secondary_range_name    = var.pod_range
    services_secondary_range_name = var.service_range
  }

  # create_service_account = true
  # service_account        = var.compute_engine_service_account

  default_max_pods_per_node = 50


    node_config {
        boot_disk_kms_key           = null
        disk_size_gb                = 40
        disk_type                   = "pd-standard"

        enable_confidential_storage = false
        guest_accelerator           = []
        image_type                  = "COS_CONTAINERD"
        labels                      = {
            "cluster_name" = "hellocluster"
            "node_pool"    = "n1-pool"
        }
        local_ssd_count             = 0
        logging_variant             = "DEFAULT"
        machine_type                = "e2-standard-4"
        metadata                    = {
            "cluster_name"             = "hellocluster"
            "disable-legacy-endpoints" = "true"
            "node_pool"                = "n1-pool"
        }
        min_cpu_platform            = null
        node_group                  = null
        oauth_scopes                = [
            "https://www.googleapis.com/auth/cloud-platform",
        ]
        preemptible                 = false
        resource_labels             = {}
        resource_manager_tags       = {}

        spot                        = true
        tags                        = [
            "gke-hellocluster",
            "gke-hellocluster-n1-pool",
        ]

        shielded_instance_config {
            enable_integrity_monitoring = true
            enable_secure_boot          = false
        }

    }

depends_on = [google_compute_subnetwork.hellosubnet, google_compute_network.hellovpc]
}
