# -------------------------
# --- regular arguments ---
# -------------------------
variable "vpc_cidr_block" {
  description = "the vpc cidr block"
  type        = string
}

# -------------------------
# ------- tags list -------
# -------------------------
variable "vpc_name_tag" {
  description = "the vpc name for tagging"
  type        = string
}

variable "env_tag" {
  description = "the environment it belongs to for tagging"
  type        = string
}