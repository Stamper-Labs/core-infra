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
# ------ custom tags ------
# -------------------------

variable "tf_name_tag" {
  description = "the terraform resource name tag"
  type        = string
}

variable "stack_tag" {
  description = "the core-infra stack name"
  type = string
}

variable "env_tag" {
  description = "the environment the resource is associated to"
  type = string
  default = "core-infra"
}