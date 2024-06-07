terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.32.0"
    }
    # yaml = {
    #   source  = "hashicorp/yaml"
    #   version = "~> 1.0"
    # }
  }
}

provider "yaml" {}

data "yaml_decode" "bucket_config" {
  input = file("${path.module}/input.yaml")
}

module "gcs_buckets" {
  source  = "../"
  buckets = data.yaml_decode.result.buckets
}
