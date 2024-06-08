output "cluster_name" {
  value = [ for cluster in google_container_cluster.private : cluster.name ]

}