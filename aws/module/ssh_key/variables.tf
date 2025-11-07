variable "name" {
  description = "Name of the SSH key in Lightsail"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file (optional, will generate if not provided)"
  type        = string
  default     = ""
}

variable "private_key_folder" {
  description = "Folder to save the private key"
  type        = string
  default     = "./dist"
}