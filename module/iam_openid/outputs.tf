output "oidc_provider_arn" {
  description = "The ARN of the IAM OIDC provider"
  value       = aws_iam_openid_connect_provider.this.arn
}