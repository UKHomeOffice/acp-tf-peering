
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dest_tables | A list of routing tables id for the destination VPC | string | `<list>` | no |
| source_tables | A list of routing tables id for the source VPC | string | `<list>` | no |
| vpc_dest | A destination map containing the keys, vpc_id, account_id and name | map | - | yes |
| vpc_source | A source map containing the keys, vpc_id, account_id and name | map | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| peering_id | The peering connection id for the connection |
| vpc_dest | The destination vpc id of the peering connection |
| vpc_source | The source vpc id of the peering connection |

