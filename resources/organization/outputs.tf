output "organization" {
  value = data.google_organization.organization
}

output "name" {
  value = data.google_organization.organization.name
}

output "org_id" {
  value = data.google_organization.organization.org_id
}

output "directory_customer_id" {
  value = data.google_organization.organization.directory_customer_id
}

output "domain" {
  value = data.google_organization.organization.domain
}
