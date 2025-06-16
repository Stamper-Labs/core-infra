# -------------------------
# --- regular arguments ---
# -------------------------
variable "domain" {
  description = "the domain"
  type        = string
}


# -------------------------
# ------- tags list -------
# -------------------------
variable "eip_name_tag" {
  description = "the eip name for tagging"
  type        = string
}

variable "env_tag" {
  description = "the environment for tagging"
  type        = string
}