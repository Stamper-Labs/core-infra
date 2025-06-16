# -------------------------
# --- regular arguments ---
# -------------------------
variable "vpc_id" {
  description = "the vpc id"
  type        = string
}

variable internet_gw_id {
  description = "The internet gateway id"
  type = string
}

variable public_subnet_id {
  description = "the public subnet id"
  type = string
}

# -------------------------
# ------- tags list -------
# -------------------------
variable "route_table_name_tag" {
  description = "the route table name for tagging"
  type        = string
}

variable "env_tag" {
  description = "the environment it belongs to for tagging"
  type        = string
}