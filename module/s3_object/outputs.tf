output "s3_object_url" {
  value = "https://${var.bucket_name}.s3.amazonaws.com/${var.object_key}"
}