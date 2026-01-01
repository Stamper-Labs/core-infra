variable "name" {
  description = "The name of the Lightsail instance."
  type        = string
}

variable "availability_zone" {
  description = "AWS Availability Zone for the instance (e.g., us-east-1a)."
  type        = string
}

variable "blueprint_id" {
  description = "The Lightsail blueprint ID (e.g., amazon_linux_2, ubuntu_22_04)."
  type        = string
  default     = "ubuntu_22_04"
}

variable "bundle_id" {
  description = "The Lightsail bundle ID for the instance size (e.g., nano_2_0, micro_2_0)."
  type        = string
  default     = "micro_2_0"
}

variable "user_data" {
  description = "Optional user data script for instance initialization."
  type        = string
  default     = ""
}

variable "env_tag" {
  description = "the environment"
  type = string
}

variable "key_pair_name" {
  description = "The name of the ssh key of the Lightsail instance."
  type        = string
}
