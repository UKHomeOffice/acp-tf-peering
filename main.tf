/**
* ## Usage
* ---
*
* ### Peering with same source and destination accounts
*
* In the providers block, you may use any of the prescribed providers from the parent 
* module which is calling this module.  In this example, I have used the same provider
* which was from the acp_test_resources repo.
*
* ```yaml
* 
* module "peering_example" {
*   source = "git::https://github.com/UKHomeOffice/acp-tf-peering?ref=v1.0.2"
* 
*   providers = {
*     aws.source = aws.eu-west-2
*     aws.dest   = aws.eu-west-2
*   }
* 
*   auto_accept = true
* 
*   vpc_source = {
*     vpc_id     = "vpc-******"
*     account_id = "******"
*     name       = "******"
*     vpc_cidr   = "******"
*   }
* 
*   vpc_dest = {
*     vpc_id     = "vpc-******"
*     account_id = "******"
*     name       = "******"
*     vpc_cidr   = "******"
*   }
* }
* 
* ```
* 
* ### Peering between source and destination in different accounts
*
* When you need to peer between VPCs in different accounts, you can
* use the providers block to select different providers as stated in the parent
* modules variables that is calling this module.
*
* ```yaml
* module "peer_acp_ci_to_acp_ops" {
*   source = "git::https://github.com/UKHomeOffice/acp-tf-peering.git?ref=v1.0.2"
* 
*   providers = {
*     aws.source = aws.acp-ci
*     aws.dest   = aws.acp-ops
*   }
* 
*   vpc_source = {
*     name       = "acp-ci"
*     account_id = data.terraform_remote_state.acp-ci.outputs.account_id
*     vpc_cidr   = data.terraform_remote_state.acp-ci.outputs.vpc_cidr
*     vpc_id     = data.terraform_remote_state.acp-ci.outputs.vpc_id
*   }
* 
*   vpc_dest = {
*     name       = "acp-ops"
*     account_id = var.acp_ops["account_id"]
*     vpc_cidr   = var.acp_ops["vpc_cidr"]
*     vpc_id     = var.acp_ops["vpc_id"]
*   }
* 
*   source_tables = concat(values(data.terraform_remote_state.acp-ci.outputs.zone_gws), [data.terraform_remote_state.acp-ci.outputs.default_gw])
* 
*   dest_tables = split(",", var.acp_ops["route_table_ids"])
* 
* }
* 
* ```
*/

terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 3.70"
      configuration_aliases = [aws.source, aws.dest]
    }
  }
  required_version = ">= 1.0"
}

## Request a peering connection from destination to source
resource "aws_vpc_peering_connection" "request" {
  provider = aws.source

  auto_accept   = var.auto_accept
  peer_owner_id = var.vpc_dest["account_id"]
  peer_region   = var.peer_region
  peer_vpc_id   = var.vpc_dest["vpc_id"]
  vpc_id        = var.vpc_source["vpc_id"]

  tags = {
    Name = format("%s - %s", var.vpc_source["name"], var.vpc_dest["name"])
  }
}

## Accept the VPC connection on the other end
resource "aws_vpc_peering_connection_accepter" "accept" {
  count    = var.auto_accept ? 0 : 1
  provider = aws.dest

  auto_accept               = true
  vpc_peering_connection_id = aws_vpc_peering_connection.request.id

  tags = {
    Name = format("%s - %s", var.vpc_dest["name"], var.vpc_source["name"])
  }
}

## Add routing to the source VPC
resource "aws_route" "source_routes" {
  count = length(var.source_tables)
  depends_on = [
    aws_vpc_peering_connection_accepter.accept,
    aws_vpc_peering_connection.request,
  ]
  provider = aws.source

  destination_cidr_block    = var.vpc_dest["vpc_cidr"]
  route_table_id            = var.source_tables[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.request.id
}

## Add routing to the destination VPC
resource "aws_route" "dest_routes" {
  count = length(var.dest_tables)
  depends_on = [
    aws_vpc_peering_connection_accepter.accept,
    aws_vpc_peering_connection.request,
  ]
  provider = aws.dest

  destination_cidr_block    = var.vpc_source["vpc_cidr"]
  route_table_id            = var.dest_tables[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.request.id
}