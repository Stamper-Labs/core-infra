resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}