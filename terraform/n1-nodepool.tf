# module.gke.google_container_node_pool.pools["default-node-pool"]:
resource "google_container_node_pool" "n1-pool" {
    cluster                     = "hellocluster"
    # initial_node_count          = 1

    location                    = "us-east1"

    max_pods_per_node           = 50
    name                        = "n1-pool"
    name_prefix                 = null
    node_count                  = 1
    node_locations              = [
        "us-east1-b"
    ]
    project                     = "helloworld-420017"
    version                     = "1.27.11-gke.1062001"

    autoscaling {
        location_policy      = "BALANCED"
        max_node_count       = 1
        min_node_count       = 1
        total_max_node_count = 0
        total_min_node_count = 0
    }

    management {
        auto_repair  = true
        auto_upgrade = true
    }

    network_config {

        pod_range            = "pod-range"
    }

    node_config {
        boot_disk_kms_key           = null
        disk_size_gb                = 100
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
        machine_type                = "n1-standard-2"
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
        service_account             = "tf-gke-hellocluster-tzw9@helloworld-420017.iam.gserviceaccount.com"
        spot                        = true
        tags                        = [
            "gke-hellocluster",
            "gke-hellocluster-n1-pool",
        ]

        shielded_instance_config {
            enable_integrity_monitoring = true
            enable_secure_boot          = false
        }

        workload_metadata_config {
            mode = "GKE_METADATA"
        }
    }

    timeouts {
        create = "45m"
        delete = "45m"
        update = "45m"
    }

    upgrade_settings {
        max_surge       = 0
        max_unavailable = 0
        strategy        = "SURGE"
    }
}