# use the gke module to build a basic gke cluster.  
# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest


data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 30.0"

  project_id = var.project_id
  name       = "hellocluster"
  region     = var.region
  network    = var.network
  subnetwork = var.subnetwork

  ip_range_pods          = var.pod_range
  ip_range_services      = var.service_range
  create_service_account = true
  # service_account        = var.compute_engine_service_account
  deletion_protection    = false
  default_max_pods_per_node = 50

  depends_on = [google_compute_subnetwork.hellosubnet, google_compute_network.hellovpc]
}