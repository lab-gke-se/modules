resource "google_org_policy_policy" "policy" {
  for_each = { for entry in var.policies : entry.policy.name => entry.policy }

  parent = var.parent
  name   = "${var.parent}/policies/${each.key}"

  spec {
    inherit_from_parent = try(each.value.spec.inherit_from_parent, null)

    dynamic "rules" {
      for_each = try(each.value.spec.rules, [])
      content {
        # Bug in provider, thought this was fixed ...
        enforce   = try(rules.value.enforce, null) != null ? rules.value.enforce ? "TRUE" : "FALSE" : null
        allow_all = try(rules.value.allow_all, null) != null ? rules.value.allow_all ? "TRUE" : "FALSE" : null
        deny_all  = try(rules.value.deny_all, null) != null ? rules.value.deny_all ? "TRUE" : "FALSE" : null
        dynamic "values" {
          for_each = try(rules.value.values, null) != null ? [1] : []
          content {
            allowed_values = try(rules.value.values.allowed_values, null)
            denied_values  = try(rules.value.values.denied_values, null)
          }
        }
      }
    }
  }
}
