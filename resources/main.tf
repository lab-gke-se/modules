locals {

  regex_parent = "(?P<type>.*)/(?P<name>.*)"

  service_accounts = flatten([
    for project in try(var.config.projects, []) : [
      for service_account in try(project.serviceAccounts, []) : [
        { project = project, service_account = service_account }
      ]
    ]
  ])
}

module "organizations" {
  source   = "../resources/organization"
  for_each = { for organization in try(var.config.organizations, []) : organization.displayName => organization }

  domain = each.value.displayName
}

module "folders" {
  source   = "../resources/folder"
  for_each = { for folder in try(var.config.folders, []) : folder.displayName => folder }

  display_name = each.value.displayName
  parent       = module.organizations[regex(local.regex_parent, each.value.parent).name].name
}

//TODO - need to read existing folders in case they aren't being created in the configuration passed in 
module "projects" {
  source   = "../resources/project"
  for_each = { for project in try(var.config.projects, []) : project.displayName => project }

  name            = each.value.displayName
  folder          = module.folders[regex(local.regex_parent, each.value.parent).name].name
  services        = each.value.services
  billing_account = try(each.value.billingAccount, var.billing_account)
  labels          = try(each.value.labels, var.labels)
}

