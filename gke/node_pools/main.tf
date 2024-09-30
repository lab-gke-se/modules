module "node_pool" {
  source   = "../node_pool"
  for_each = { for nodePool in var.nodePools : nodePool.name => nodePool }

  # Terraform / cluster variables
  project  = var.project
  cluster  = var.cluster
  location = var.location

  # Node Pool variables
  name                   = each.value.name
  initialNodeCount       = try(each.value.initialNodeCount, null)
  config                 = try(each.value.config, null)
  locations              = try(each.value.locations, null)
  networkConfig          = try(each.value.networkConfig, null)
  nodeVersion            = try(each.value.version, null)
  autoscaling            = try(each.value.autoscaling, null)
  management             = try(each.value.management, null)
  maxPodsConstraint      = try(each.value.maxPodsConstraint, null)
  upgradeSettings        = try(each.value.upgradeSettings, null)
  placementPolicy        = try(each.value.placementPolicy, null)
  queuedProvisioning     = try(each.value.queuedProvisioning, null)
  bestEffortProvisioning = try(each.value.bestEffortProvisioning, null)

}
