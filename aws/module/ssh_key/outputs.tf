output "name" {
  value = aws_lightsail_key_pair.this.name
}

output "private_key_path" {
  value = var.public_key_path != "" ? var.public_key_path : local_file.this[0].filename
}