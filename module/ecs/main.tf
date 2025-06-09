resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
  tags = {
    Name        = var.ecs_cluster_name
    Environment = var.env_tag
  }
}
