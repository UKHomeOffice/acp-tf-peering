
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| tags | A map of tags applied the vpc peering connections | string | - | yes |
| vpc_source | A source map containing the keys, vpc_id, account_id, vpc_cidr and profile | map | - | yes |
| vpn_dest | A destination map containing the keys, vpc_id, account_id, vpc_cidr and profile | map | - | yes |

