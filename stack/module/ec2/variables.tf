variable "ec2_instance_type" {
  description = "The type of ec2 instance to power on"
  type    = string
}

variable "ec2_ami_id" {
  description = "The AMI to clone the EC2 instance from"
  type        = string
}

variable "subnet_id" {
  description = "The subnet where the instace will be deployed"
  type        = string
}

variable "add_public_ip" {
  description = "Determines if the EC2 must be associated a public IP address"
  type        = bool
}

variable "security_group_ids" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
}

variable "ssm_profile_name" {
  description = "the name of the ssm profile"
  type        = string
}

variable "ssm_role_name" {
  description = "the name of the ssm role"
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