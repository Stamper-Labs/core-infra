variable "role_name" {
  description = "the role name"
  type        = string
}

variable "assume_role_policy" {
  description = "the assume role policy"
  type        = string
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

# -------------------------
# ------- tags list -------
# -------------------------

variable "env_tag" {
  description = "the environment for tagging"
  type        = string
}
