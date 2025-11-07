# Generate a new SSH key if no public key is provided
resource "tls_private_key" "this" {
  count     = var.public_key_path == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key locally (only if generated)
resource "local_file" "this" {
  count           = var.public_key_path == "" ? 1 : 0
  content         = tls_private_key.this[0].private_key_pem
  filename        = "${pathexpand(var.private_key_folder)}/${var.name}_private.pem"
  file_permission = "0600"
}

# Choose public key: either user-provided or generated
locals {
  public_key_content = var.public_key_path != "" ? file(var.public_key_path) : tls_private_key.this[0].public_key_openssh
}

# Create Lightsail SSH key
resource "aws_lightsail_key_pair" "this" {
  name       = var.name
  public_key = local.public_key_content
}