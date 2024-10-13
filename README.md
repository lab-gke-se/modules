# Modules
This repository contains a set of terraform modules for the google cloud platform. The modules are written to a standard pattern to abstract away from the terraform language and prove modules that mirror the google cloud apis. This intention is that this is a stepping stone to moving away from terraform towards a configuration management approach to cloud infrasturcture. 

# Usage
The general usage pattern is the same for all modules. Firstly, create a yaml file with the definition of the resource you want to create. You can create yaml files by hand or extract them from existing cloud resources. Next, write a standard terraform module to read the yaml file and pass the variable high level objects to the corresponding terraform module.

# Example 
There are many examples in the example folder but they all follow the same general pattern. The following yaml file shows a typical artifact registry definition for a docker repository. The project, location, repo_name and kms_key have been abstracted to provide a common template. 

```
cleanupPolicyDryRun: true
dockerConfig: {}
format: DOCKER
mode: STANDARD_REPOSITORY
name: projects/${project}/locations/${location}/repositories/${repo_name}
kmsKeyName: ${kms_key}
```

The following terraform code shows how to read the yaml file, substituting known values for the abstracted values and then calls the artifact registry module with the parameters from the yaml file. 

```
locals {
  substitutions = {
    kms_key         = module.kms_key.key_id
    project         = "prj-test-1"
    location        = "us-east4"
    repo_name       = "images"
  }

  artifactregistry_config = yamldecode(templatefile("${path.module}/config/artifactregistry/${filename}", local.substitutions)) 
}

module "registry" {
  source   = "github.com/lab-gke-se/modules//artifactregistry?ref=0.0.4"

  project                 = local.project
  name                    = artifactregistry_config.name
  format                  = artifactregistry_config.format
  description             = try(artifactregistry_config.description, null)
  labels                  = try(artifactregistry_config.labels, null)
  kmsKeyName              = try(artifactregistry_config.kmsKeyName, null)
  mode                    = try(artifactregistry_config.mode, null)
  cleanupPolicies         = try(artifactregistry_config.cleanupPolices, null)
  cleanupPolicyDryRun     = try(artifactregistry_config.cleanupPolicyDryRun, null)
  mavenConfig             = try(artifactregistry_config.mavenConfig, null)
  dockerConfig            = try(artifactregistry_config.dockerConfig, null)
  virtualRepositoryConfig = try(artifactregistry_config.virtualRepositoryConfig, null)
  remoteRepositoryConfig  = try(artifactregistry_config.remoteRepositoryConfig, null)
}
```