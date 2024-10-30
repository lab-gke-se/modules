<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed"></a> [allowed](#input\_allowed) | The allowed ports and protocols for the firewall rule | `any` | `null` | no |
| <a name="input_denied"></a> [denied](#input\_denied) | The denied ports and protocols for the firewall rule | `any` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the firewall rule | `string` | `null` | no |
| <a name="input_destinationRanges"></a> [destinationRanges](#input\_destinationRanges) | The destination ranges for the firewall rule | `list(string)` | `null` | no |
| <a name="input_direction"></a> [direction](#input\_direction) | The direction of the firewall rule | `string` | `null` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Set to true if the firewall rule is disabled | `bool` | `null` | no |
| <a name="input_logConfig"></a> [logConfig](#input\_logConfig) | The log configuration for the firewall rule | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the firewall rule | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The network the firewall rule applies to | `string` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | The priority of the firewall rule | `number` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | The project hosting the firewall rule | `string` | n/a | yes |
| <a name="input_sourceRanges"></a> [sourceRanges](#input\_sourceRanges) | The source ranges for the firewall rule | `list(string)` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->