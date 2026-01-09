resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}