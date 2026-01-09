variable "connector_url" {
  description = "value of the OIDC provider URL"
  type        = string
}

variable "openid_client_id_list" {
  description = "List of client IDs (audiences) for the OIDC provider"
  type        = list(string)
}

variable "openid_thumbprint_list" {
  description = "List of thumbprints for the OIDC provider"
  type        = list(string)
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