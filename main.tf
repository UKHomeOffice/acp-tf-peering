
## The source provider
provider "aws" {
  alias   = "source"
  profile = "${var.vpc_source["name"]}"
}

## The destination provider
provider "aws" {
  alias   = "dest"
  profile = "${var.vpc_dest["name"]}"
}

## Request a peering connection from destination to source
resource "aws_vpc_peering_connection" "request" {
  provider                          = "aws.dest"

  auto_accept                       = "true"
  peer_owner_id                     = "${var.vpc_dest["account_id"]}"
  peer_vpc_id                       = "${var.vpc_dest["vpc_id"]}"
  vpc_id                            = "${var.vpc_source["vpc_id"]}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = "${merge(var.tags, map("Name", format("%s - %s", var.vpc_source["name"], var.vpc_dest["name"])))}"
}

## Accept the VPC connection on the other end
resource "aws_vpc_peering_connection_accepter" "accept" {
  provider                          = "aws.source"

  auto_accept                       = true
  vpc_peering_connection_id         = "${aws_vpc_peering_connection.request.id}"

  tags = "${merge(var.tags, map("Name", format("%s - %s", var.vpc_dest["name"], var.vpc_source["name"])))}"
}

