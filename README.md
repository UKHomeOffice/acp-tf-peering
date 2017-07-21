
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| dest_tables | A list of routing tables id for the destination VPC | `<list>` | no |
| source_tables | A list of routing tables id for the source VPC | `<list>` | no |
| vpc_dest | A destination map containing the keys, vpc_id, account_id and name | - | yes |
| vpc_source | A source map containing the keys, vpc_id, account_id and name | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| peering_id |  |
| vpc_dest |  |
| vpc_source |  |

