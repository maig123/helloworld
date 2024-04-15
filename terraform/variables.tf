variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "network" {
  description = "The VPC network to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}

variable "ip_subnet_range" {
  description = "The ip range to use for the subnetwork"
}

variable "ip_pod" {
  description = "The secondary ip range to use for pods"
}

variable "ip_service" {
  description = "The secondary ip range to use for services"
}

variable "pod_range" {
  description = "The name of the range to use for pods"
}

variable "service_range" {
  description = "The name of the range to use for services"
}

