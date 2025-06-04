
resource "aws_iam_openid_connect_provider" "this" {
  url             = var.connector_url
  client_id_list  = var.openid_client_id_list
  thumbprint_list = var.openid_thumbprint_list
  tags = {
    Environment = var.env_tag
  }
}