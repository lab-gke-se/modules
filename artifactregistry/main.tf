resource "google_artifact_registry_repository" "repository" {
  project                = split("/", var.name)[1]
  location               = split("/", var.name)[3]
  repository_id          = split("/", var.name)[5]
  format                 = var.format
  description            = var.description
  labels                 = var.labels
  kms_key_name           = var.kmsKeyName
  mode                   = var.mode
  cleanup_policy_dry_run = var.cleanupPolicyDryRun
  #   size_bytes                = var.sizeBytes
  #   disallow_unspecified_mode = var.disallowUnspecifiedMode
  #   "satisfiesPzs": boolean,
  #   "satisfiesPzi": boolean,

  dynamic "cleanup_policies" {
    for_each = try(var.cleanupPolicies, null) != null ? [var.cleanupPolicies] : []

    content {
      id     = cleanup_policies.value.id
      action = cleanup_policies.value.action

      dynamic "condition" {
        for_each = try(cleanup_policies.value.condition, null) != null ? [cleanup_policies.value.condition] : []

        content {
          tag_prefixes          = condition.value.tagPrefixes
          package_name_prefixes = condition.value.packageNamePrefixes
          tag_state             = condition.value.tagState
          older_than            = condition.value.olderThan
          newer_than            = condition.value.newerThan
          //          version_name_prefixed = condition.value.versionNamePrefixes
        }
      }

      dynamic "most_recent_versions" {
        for_each = try(cleanup_policies.value.mostRecentVersions, null) != null ? [cleanup_policies.value.mostRecentVersions] : []

        content {
          package_name_prefixes = most_recent_versions.value.packageNamePrefixes
          keep_count            = most_recent_versions.value.keepCount
        }
      }
    }
  }

  dynamic "maven_config" {
    for_each = try(var.mavenConfig, null) != null ? [var.mavenConfig] : []

    content {
      allow_snapshot_overwrites = maven_config.value.allowSnapshotOverwrites
      version_policy            = maven_config.value.versionPolicy
    }
  }

  dynamic "docker_config" {
    for_each = try(var.dockerConfig, null) != null ? [var.dockerConfig] : []

    content {
      immutable_tags = docker_config.value.immutableTags
    }
  }

  dynamic "virtual_repository_config" {
    for_each = try(var.virtualRepositoryConfig, null) != null ? [var.virtualRepositoryConfig] : []

    content {
      dynamic "upstream_policies" {
        for_each = try(virtual_repository_config.value.upstreamPolicies, null) != null ? [virtual_repository_config.value.upstreamPolicies] : []

        content {
          id         = upstream_policies.value.id
          repository = upstream_policies.value.repository
          priority   = upstream_policies.value.priority
        }
      }
    }
  }

  dynamic "remote_repository_config" {
    for_each = try(var.remoteRepositoryConfig, null) != null ? [var.remoteRepositoryConfig] : []

    content {
      description                 = remote_repository_config.value.description
      disable_upstream_validation = remote_repository_config.value.disableUpstreamValidation
      dynamic "upstream_credentials" {
        for_each = try(remote_repository_config.value.upstreamCredentials, null) != null ? [remote_repository_config.value.upstreamCredentials] : []

        content {
          dynamic "username_password_credentials" {
            for_each = try(upstream_credentials.value.usernamePasswordCredentials, null) != null ? [upstream_credentials.value.usernamePasswordCredentials] : []

            content {
              username                = username_password_credentials.value.username
              password_secret_version = username_password_credentials.calue.passwordSecretVersion
            }
          }
        }
      }

      dynamic "docker_repository" {
        for_each = try(remote_repository_config.value.dockerRepository, null) != null ? [remote_repository_config.value.dockerRepository] : []

        content {
          public_repository = docker_repository.value.publicRepository

          dynamic "custom_repository" {
            for_each = try(docker_repository.value.customRepository, null) != null ? [docker_repository.value.customRepository] : []

            content {
              uri = customer_repository.value.uri
            }
          }
        }
      }

      dynamic "maven_repository" {
        for_each = try(remote_repository_config.value.mavenRepository, null) != null ? [remote_repository_config.value.mavenRepository] : []

        content {
          public_repository = maven_repository.value.publicRepository

          dynamic "custom_repository" {
            for_each = try(maven_repository.value.customRepository, null) != null ? [maven_repository.value.customRepository] : []

            content {
              uri = customer_repository.value.uri
            }
          }
        }
      }

      dynamic "npm_repository" {
        for_each = try(remote_repository_config.value.npmRepository, null) != null ? [remote_repository_config.value.npmRepository] : []

        content {
          public_repository = npm_repository.value.publicRepository

          dynamic "custom_repository" {
            for_each = try(npm_repository.value.customRepository, null) != null ? [npm_repository.value.customRepository] : []

            content {
              uri = customer_repository.value.uri
            }
          }
        }
      }

      #   dynamic "python_respository" {
      #     for_each = try(remote_repository_config.value.pythonRepository, null) != null ? [remote_repository_config.value.pythonRepository] : []

      #     content {
      #       public_repository = python_repository.value.publicRepository

      #       dynamic "custom_repository" {
      #         for_each = try(python_repository.value.customRepository, null) != null ? [python_repository.value.customRepository] : []

      #         content {
      #           uri = customer_repository.value.uri
      #         }
      #       }
      #     }
      #   }

      #   dynamic "apt_respository" {
      #     for_each = try(remote_repository_config.value.aptRepository, null) != null ? [remote_repository_config.value.aptRepository] : []

      #     content {
      #       dynamic "public_repository" {
      #         for_each = try(apt_repository.value.publicRepository, null) != null ? [apt_repository.value.publicRepository] : []

      #         content {
      #           repository_base = public_repository.value.repositoryBase
      #           repsitory_path  = public_repository.value.repositoryPath
      #         }

      #       }
      #       dynamic "custom_repository" {
      #         for_each = try(apt_repository.value.customRepository, null) != null ? [apt_repository.value.customRepository] : []

      #         content {
      #           uri = customer_repository.value.uri
      #         }
      #       }
      #     }
      #   }

      #   dynamic "yum_respository" {
      #     for_each = try(remote_repository_config.value.yumRepository, null) != null ? [remote_repository_config.value.yumRepository] : []

      #     content {
      #       dynamic "public_repository" {
      #         for_each = try(yum_repository.value.publicRepository, null) != null ? [yum_repository.value.publicRepository] : []

      #         content {
      #           repository_base = public_repository.value.repositoryBase
      #           repsitory_path  = public_repository.value.repositoryPath
      #         }

      #       }
      #       dynamic "custom_repository" {
      #         for_each = try(yum_repository.value.customRepository, null) != null ? [yum_repository.value.customRepository] : []

      #         content {
      #           uri = customer_repository.value.uri
      #         }
      #       }
      #     }
      #   }
    }
  }
}


