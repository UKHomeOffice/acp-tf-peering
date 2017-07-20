
variable "tags" {
  description = "A map of tags applied the vpc peering connections"
  default     = {}
}

variable "vpc_source" {
  description = "A source map containing the keys, vpc_id, account_id and name"
  type        = "map"
}

variable "vpn_dest" {
  description = "A destination map containing the keys, vpc_id, account_id and name"
  type        = "map"
}

