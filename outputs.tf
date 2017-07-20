
output "peering_id" {
  description = "The peering connection id for the connection"
  value       = "${aws_vpc_peering_connection.request.id}"
}

output "vpc_source" {
  description = "The source vpc id of the peering connection"
  value       = "${var.vpc_source["vpc_id"]}"
}

output "vpc_dest" {
  description = "The destination vpc id of the peering connection"
  value       = "${var.vpc_dest["vpc_id"]}"
}
