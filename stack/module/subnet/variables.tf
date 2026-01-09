# -------------------------
# --- regular arguments ---
# -------------------------
variable "vpc_id" {
  description = "the vpc id"
  type        = string
}

variable "cidr_block" {
  description = "the ip range the subnet is able to address"
  type = string
}

variable "map_public_ip_on_launch" {
  description = "if a public ip is assigned at launch"
  type = bool
}

variable "availability_zone" {
  description = "the availability zone where the subnet is deployed"
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