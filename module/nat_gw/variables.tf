# -------------------------
# --- regular arguments ---
# -------------------------
variable "elastic_ip_id" {
  description = "the elastic ip id"
  type        = string
}

variable "public_subnet_id" {
  description = "the public subnet id"
  type        = string
}

# -------------------------
# ------- tags list -------
# -------------------------

variable "nat_gw_name_tag" {
  description = "the nat gw name for tagging"
  type        = string
}

variable "env_tag" {
  description = "the environment"
  type = string
}