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
# ------- tags list -------
# -------------------------
variable "subnet_name_tag" {
  description = "the subnet name for tagging"
  type        = string
}

variable "env_tag" {
  description = "the environment it belongs to for tagging"
  type        = string
}