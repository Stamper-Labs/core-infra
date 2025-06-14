# -------------------------
# --- regular arguments ---
# -------------------------
variable "vpc_id" {
  description = "the vpc id"
  type        = string
}

variable nat_gateway_id {
  description = "The nat gateway id"
  type = string
}

variable private_subnet_id {
  description = "the private subnet id"
  type = string
}

# -------------------------
# ------- tags list -------
# -------------------------
variable "route_table_name_tag" {
  description = "the route table name for tagging"
  type        = string
}