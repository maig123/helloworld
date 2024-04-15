terraform {
    
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 5.24"
        }

    }
    backend "gcs" {
        bucket = "helloworld-tfstate"
    }

}

provider "google" {
    project = var.project_id
    region = var.region
    
}

