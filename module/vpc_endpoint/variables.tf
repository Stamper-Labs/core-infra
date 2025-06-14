# -------------------------
# --- regular arguments ---
# -------------------------

variable vpc_id {
  description = "the vpc id to create the endpoint in"
  type        = string
}

variable "service_name" {
  description = "the service name for the vpc endpoint"
  type        = string
}

variable "vpc_endpoint_type" {
  description = "the type of vpc endpoint, either Interface or Gateway"
  type        = string
  default     = "Interface"
}

variable "subnet_ids" {
  description = "the list of subnet ids to create the endpoint in"
  type        = set(string)  
}

variable "security_group_ids" {
  description = "the list of security group ids to associate with the endpoint"
  type        = set(string)
}

# -------------------------
# ------- tags list -------
# -------------------------

variable "vpc_endpoint_name_tag" {
  description = "the vpc name for tagging"
  type        = string
}

variable "env_tag" {
  description = "the environment for tagging"
  type        = string
}