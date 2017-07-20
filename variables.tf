
variable "tags" {
  description = "A map of tags applied the vpc peering connections"
}

variable "vpc_source" {
  description = "A source map containing the keys, vpc_id, account_id, vpc_cidr and profile"
  description = "The source VPN"
  type        = "map"
}

variable "vpn_dest" {
  description = "A destination map containing the keys, vpc_id, account_id, vpc_cidr and profile"
  type        = "map"
}

