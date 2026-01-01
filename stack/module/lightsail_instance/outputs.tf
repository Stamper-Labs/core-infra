output "instance_name" {
  description = "The name of the Lightsail instance."
  value       = aws_lightsail_instance.this.name
}

output "public_ip_address" {
  description = "The public IP address of the Lightsail instance."
  value       = aws_lightsail_instance.this.public_ip_address
}

output "username" {
  description = "The default username for the Lightsail instance."
  value       = aws_lightsail_instance.this.username
}