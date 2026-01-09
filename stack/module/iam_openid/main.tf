
resource "aws_iam_openid_connect_provider" "this" {
  url             = var.connector_url
  client_id_list  = var.openid_client_id_list
  thumbprint_list = var.openid_thumbprint_list
  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}