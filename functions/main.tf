resource "google_cloudfunctions_function" "function" {
  project                       = split("/", var.name)[1]
  name                          = split("/", var.name)[5]
  region                        = split("/", var.name)[3]
  description                   = var.description
  entry_point                   = var.entryPoint
  runtime                       = var.runtime
  timeout                       = var.timeout
  available_memory_mb           = var.availableMemoryMb
  service_account_email         = var.serviceAccountEmail
  labels                        = var.labels
  environment_variables         = var.environmentVariables
  build_environment_variables   = var.buildEnvironmentVariables
  min_instances                 = var.minInstances
  max_instances                 = var.maxInstances
  vpc_connector                 = var.vpcConnector
  vpc_connector_egress_settings = var.vpcConnectorEgressSettings
  ingress_settings              = var.ingressSettings
  kms_key_name                  = var.kmsKeyName
  build_worker_pool             = var.buildWorkerPool
  source_archive_bucket         = split("/", var.sourceArchiveUrl)[2]
  source_archive_object         = split("/", var.sourceArchiveUrl)[3]
  docker_repository             = var.dockerRepository
  docker_registry               = var.dockerRegistry
  build_service_account         = var.buildServiceAccount

  dynamic "secret_environment_variables" {
    for_each = try(var.secretEnvironmentVariables, null) != null ? [var.secretEnvironmentVariables] : []

    content {
      key        = secret_environment_variables.values.key
      project_id = secret_envrionment_variables.value.projectId
      secret     = secret_environment_variables.values.secret
      version    = secret_environment_variables.values.version
    }
  }

  dynamic "secret_volumes" {
    for_each = try(var.secretVolumes, null) != null ? var.secretVolumes : []

    content {
      mount_path = secret_volumes.values.mountPath
      project_id = secret_volumes.values.project_id
      secret     = secret_volumes.values.secret

      dynamic "versions" {
        for_each = try(secret_volumes.values.versions, null) != null ? secret_volumes.values.versions : {}

        content {
          path    = versions.values.path
          version = versions.values.version
        }
      }
    }
  }

  dynamic "event_trigger" {
    for_each = try(var.eventTrigger, null) != null ? [var.eventTrigger] : []

    content {
      event_type = event_trigger.value.eventType
      resource   = event_trigger.value.resource

      dynamic "failure_policy" {
        for_each = try(event_trigger.values.failurePolicy, null) != null ? [event_trigger.values.failuerPolicy] : []

        content {
          retry = failure_policy.values.retry
        }
      }
    }
  }

  trigger_http = try(var.httpsTrigger, null) != null ? true : null

  # dynamic "http_trigger" {
  #   for_each = try(var.httpsTrigger, null) != null ? [var.httpsTrigger] : []

  #   content {
  #     securityLevel = http_trigger.value.securityLevel
  #   }
  # }

  dynamic "source_repository" {
    for_each = try(var.sourceRepository, null) != null ? [var.sourceRepository] : []

    content {
      url = source_repository.values.url
    }
  }
}
