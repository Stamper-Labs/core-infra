# -------------------------
# --- regular arguments ---
# -------------------------

variable "vpc_cidr_block" {
  description = "the vpc cidr block"
  type        = string
}

variable "subnet_cidr_block" {
  description = "the subnet cidr block"
  type        = string
}

variable "subnet_availability_zone" {
  description = "the availability zone"
  type        = string
}

variable "route_destination_cidr_block" {
  description = "valthe destination cidr block of the route"
  type        = string
}

# -------------------------
# ------- tags list -------
# -------------------------

variable "vpc_name_tag" {
  description = "the vpc name for tagging"
  type        = string
}

variable "subnet_name_tag" {
  description = "the subnet name for tagging"
  type        = string
}

variable "internet_gateway_name_tag" {
  description = "the internet gateway name for tagging"
  type        = string
}

variable "route_table_name_tag" {
  description = "the route table name for tagging"
  type        = string
}
