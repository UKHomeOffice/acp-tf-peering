variable "auto_accept" {
  description = "Indicated we should attempt to accept on the peering side"
  default     = true
}

variable "peer_region" {
  description = "The peering region if we are going across region"
  default     = ""
}

variable "dest_tables" {
  description = "A list of routing tables id for the destination VPC"
  default     = []
}

variable "source_tables" {
  description = "A list of routing tables id for the source VPC"
  default     = []
}

variable "vpc_source" {
  description = "A source map containing the keys, vpc_id, account_id and name"
  type        = "map"
}

variable "vpc_dest" {
  description = "A destination map containing the keys, vpc_id, account_id and name"
  type        = "map"
}
