<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.dest"></a> [aws.dest](#provider\_aws.dest) | 3.71.0 |
| <a name="provider_aws.source"></a> [aws.source](#provider\_aws.source) | 3.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route.dest_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.source_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.request](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.accept](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_accept"></a> [auto\_accept](#input\_auto\_accept) | Indicated we should attempt to accept on the peering side | `bool` | `false` | no |
| <a name="input_dest_tables"></a> [dest\_tables](#input\_dest\_tables) | A list of routing tables id for the destination VPC | `list(string)` | `[]` | no |
| <a name="input_peer_region"></a> [peer\_region](#input\_peer\_region) | The peering region if we are going across region | `string` | `""` | no |
| <a name="input_source_tables"></a> [source\_tables](#input\_source\_tables) | A list of routing tables id for the source VPC | `list(string)` | `[]` | no |
| <a name="input_vpc_dest"></a> [vpc\_dest](#input\_vpc\_dest) | A destination map containing the keys, vpc\_id, account\_id and name | `map(string)` | n/a | yes |
| <a name="input_vpc_source"></a> [vpc\_source](#input\_vpc\_source) | A source map containing the keys, vpc\_id, account\_id and name | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering_id"></a> [peering\_id](#output\_peering\_id) | The peering connection id for the connection |
| <a name="output_vpc_dest"></a> [vpc\_dest](#output\_vpc\_dest) | The destination vpc id of the peering connection |
| <a name="output_vpc_source"></a> [vpc\_source](#output\_vpc\_source) | The source vpc id of the peering connection |
<!-- END_TF_DOCS -->