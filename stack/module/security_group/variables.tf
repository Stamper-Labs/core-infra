variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
}

variable "sg_vpc_id" {
  description = "the vpc id"
  type        = string
}

variable "sg_ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "sg_egress_rules" {
  description = "Egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
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