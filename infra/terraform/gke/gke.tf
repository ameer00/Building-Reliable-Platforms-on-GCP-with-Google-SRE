module "gke" {
  for_each = {for i,v in local.fleet_clusters_info: i=>v}
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster"
  project_id                 = var.project_id
  name                       = each.value.cluster_name
  regional                   = true 
  region                     = each.value.region
  zones                      = [each.value.cluster_zone]
  network                    = each.value.network
  subnetwork                 = each.value.subnet_name
  ip_range_pods              = each.value.pod_cidr_name
  ip_range_services          = each.value.svc_cidr_name
  horizontal_pod_autoscaling = true
}

module "gke-config-cluster" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster"
  project_id                 = var.project_id
  name                       = local.config_cluster_info.cluster_name
  regional                   = true 
  region                     = local.config_cluster_info.region
  network                    = local.config_cluster_info.network
  subnetwork                 = local.config_cluster_info.subnet_name
  ip_range_pods              = local.config_cluster_info.pod_cidr_name
  ip_range_services          = local.config_cluster_info.svc_cidr_name
  horizontal_pod_autoscaling = true
}