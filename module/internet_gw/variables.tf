# -------------------------
# --- regular arguments ---
# -------------------------
variable "vpc_id" {
  description = "the vpc id"
  type        = string
}


# -------------------------
# ------- tags list -------
# -------------------------
variable "internet_gw_name_tag" {
  description = "the internet gateway name for tagging"
  type        = string
}

variable "env_tag" {
  description = "the environment internet gateway belongs for tagging"
  type        = string
}