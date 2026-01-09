variable "policy_name" {
  description = "The name of the IAM policy."
  type        = string
}

variable "policy_description" {
  description = "A description of the IAM policy."
  type        = string
}

variable "policy" {
  description = "the policy"
  type        = string
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
  default = "none"
}