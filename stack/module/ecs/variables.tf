variable "cluster_name" {
  description = "ecs cluster name"
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
  default = "core-infra"
}