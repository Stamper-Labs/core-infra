# -------------------------
# --- regular arguments ---
# -------------------------

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "object_key" {
  description = "The key (path) for the object in S3"
  type        = string
}

variable "source_file" {
  description = "Path to the local file to upload"
  type        = string
}

variable "content_type" {
  description = "MIME type of the file"
  type        = string
  default     = "application/octet-stream"
}

# -------------------------
# ------- tags list -------
# -------------------------

variable "env_tag" {
  description = "the environment for tagging"
  type        = string
}
