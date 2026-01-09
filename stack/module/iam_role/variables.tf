variable "role_name" {
  description = "the role name"
  type        = string
}

variable "assume_role_policy" {
  description = "the assume role policy"
  type        = string
}

variable "policy_arns" {
  description = "Map of policy ARNs to attach"
  type        = map(string)
  default     = {}
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
