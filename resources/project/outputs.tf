output "name" {
  value = data.google_project.project.name
}

output "project_id" {
  value = data.google_project.project.project_id
}

output "number" {
  value = data.google_project.project.number
}

output "folder_id" {
  value = data.google_project.project.project_id
}

output "services" {
  value = local.services
}

