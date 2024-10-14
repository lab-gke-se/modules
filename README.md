# Modules
This repository contains a set of terraform modules for the google cloud platform. The modules are written to a standard pattern, to abstract away from the terraform language, and provide modules that mirror the google cloud apis. This is intended as a stepping stone to moving away from terraform and towards a configuration management approach for cloud infrastructure (Infrastructure as Configuration rather than Infrastructure as code).

# Approach
The parameters for each module are written to match the google cloud api payloads and therefore no understanding of the underlying terraform is required to use the module. The module is responsible for translating from the google cloud api into the terraform resource format (that then translates it back into google cloud apis).

# Usage
The modules can be used as standard terraform module, with parameters that conform to the google cloud api, or they can be used in a configuration management approach that stores the cloud configuration in yaml files. These yaml files make it easy to define the cloud configuration and apply it using the terraform modules. They can also be used for validating and enforcing the cloud configuration using policies and guardrails. 

# Example 
The following is a simple example of how to create an artifactregistry docker repository; but all modules basically follow the same pattern. Firstly, create a yaml file with the configuration for the resource you want to create. The yaml file format is based on the google cloud rest api payload for that resource. The following is an example of the definition for a simple artifactregistry docker repository. Replace the variables with the required values for your own environment.

```
cleanupPolicyDryRun: true
dockerConfig: {}
format: DOCKER
mode: STANDARD_REPOSITORY
name: projects/${project}/locations/${location}/repositories/${repo_name}
kmsKeyName: projects/${project}/locations/${location}/keyRings/${key_ring}/cryptoKeys/${key}
```

To create this resource in google cloud, read and decode the yaml file and use the variables created as inputs to the terraform module. Make sure all optional variables are encased in try functions to set the values to null if they don't exist. 

```
locals {
  artifactregistry_config = yamldecode(file("${path.module}/config/artifactregistry/${filename}")
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

# Existing Cloud Resources
Existing cloud resources can be brought under IaC control using these modules by extracting the configuration to a yaml file, importing the resource to terraform and running an apply. 

```
gcloud artifactregistry repository describe ${repo_name} --location=${location} --project=${project} > ./config/artifactrepository/${repo_name}.yaml

terraform import module.registry ${project}/${location}/${repo_name}

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

# Drift detection and Guardrails
This same approach can be used for drift detection and writing guardrails. The yaml file becomes the golden source for the cloud coniguration, changes to the yaml files will cause the cloud configuration to change, on a terraform apply, and the cloud configuration can be extracted and compared against the golden source to detect any drift. 

Guardrails can be written that take the golden source yaml files and automatically compare any change to resources against the golden source, alerting on any differences and autoremediating back to the golden source if required. 