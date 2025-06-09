variable "ecs_cluster_name" {
  description = "ecs cluster name"
  type        = string
}

# -------------------------
# ------- tags list -------
# -------------------------

variable "env_tag" {
  description = "the environment for tagging"
  type        = string
}
