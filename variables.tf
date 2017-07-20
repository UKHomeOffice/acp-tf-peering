
variable "source_tables" {
  description = "A list of routing tables id for the source VPC"
  default     = []
}

variable "dest_tables" {
  description = "A list of routing tables id for the destination VPC"
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

