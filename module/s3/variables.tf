# -------------------------
# --- regular arguments ---
# -------------------------

variable "s3_bucket_name" {
  description = "the bucket name"
  type        = string
}

# -------------------------
# ------- tags list -------
# -------------------------

variable "env_tag" {
  description = "the environment for tagging"
  type        = string
}
