locals {
  bindings = { for binding in flatten([
    for binding in try(var.iamPolicy.bindings, []) : [
      for member in binding.members : {
        role   = binding.role
        member = member
      }
    ]
    ]) : "${binding.role}/${binding.member}" => binding
  }
}

resource "google_project_iam_member" "member" {
  for_each = local.bindings

  project = var.project
  role    = each.value.role
  member  = each.value.member
}

