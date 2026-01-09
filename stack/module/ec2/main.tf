resource "aws_instance" "this" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.add_public_ip

  vpc_security_group_ids = var.security_group_ids

  tags = {
    tf_resource = var.tf_name_tag
    stack = var.stack_tag
    env = var.env_tag
  }
}

resource "aws_iam_instance_profile" "this" {
  name = var.ssm_profile_name
  role = var.ssm_role_name
}