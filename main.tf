# AWS Source Provider
provider "aws" {
  alias = "source"
}

# AWS Destination Provider
provider "aws" {
  alias = "dest"
}

## Request a peering connection from destination to source
resource "aws_vpc_peering_connection" "request" {
  provider = "aws.source"

  auto_accept   = "${var.vpc_source["account_id"] != var.vpc_dest["account_id"] ? false : true}"
  peer_owner_id = "${var.vpc_dest["account_id"]}"
  peer_vpc_id   = "${var.vpc_dest["vpc_id"]}"
  vpc_id        = "${var.vpc_source["vpc_id"]}"

  tags = {
    Name = "${format("%s - %s", var.vpc_source["name"], var.vpc_dest["name"])}"
  }
}

## Accept the VPC connection on the other end
resource "aws_vpc_peering_connection_accepter" "accept" {
  count    = "${var.vpc_source["account_id"] != var.vpc_dest["account_id"] ? 1 : 0}"
  provider = "aws.dest"

  auto_accept               = true
  vpc_peering_connection_id = "${aws_vpc_peering_connection.request.id}"

  tags = {
    Name = "${format("%s - %s", var.vpc_dest["name"], var.vpc_source["name"])}"
  }
}

## Add routing to the source VPC
resource "aws_route" "source_routes" {
  count      = "${length(var.source_tables)}"
  depends_on = ["aws_vpc_peering_connection_accepter.accept", "aws_vpc_peering_connection.request"]
  provider   = "aws.source"

  destination_cidr_block    = "${var.vpc_dest["vpc_cidr"]}"
  route_table_id            = "${var.source_tables[count.index]}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.request.id}"
}

## Add routing to the destination VPC
resource "aws_route" "dest_routes" {
  count      = "${length(var.dest_tables)}"
  depends_on = ["aws_vpc_peering_connection_accepter.accept", "aws_vpc_peering_connection.request"]
  provider   = "aws.dest"

  destination_cidr_block    = "${var.vpc_source["vpc_cidr"]}"
  route_table_id            = "${var.dest_tables[count.index]}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.request.id}"
}
