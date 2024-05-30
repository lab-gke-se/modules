resource "google_iam_workload_identity_pool_provider" "provider" {
  project                            = var.project
  workload_identity_pool_id          = var.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  display_name                       = var.display_name
  description                        = var.description
  attribute_mapping = {
    "google.subject"           = "assertion.sub"
    "attribute.aud"            = "assertion.aud"
    "attribute.project_path"   = "assertion.project_path"
    "attribute.project_id"     = "assertion.project_id"
    "attribute.namespace_id"   = "assertion.namespace_id"
    "attribute.namespace_path" = "assertion.namespace_path"
    "attribute.user_email"     = "assertion.user_email"
    "attribute.ref"            = "assertion.ref"
    "attribute.ref_type"       = "assertion.ref_type"
  }
  oidc {
    issuer_uri        = "https://pscode.lioncloud.net"
    allowed_audiences = ["https://gitlab.com"]
  }
}
