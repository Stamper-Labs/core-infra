resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs_cluster"
  tags = {
    Name = "ecs_cluster"
  }
}

resource "aws_ecs_task_definition" "ecs_ftask_nginx" {
  family                   = "ecs_ftask_nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "ecs_fsvc_nginx_public" {
  name            = "ecs_fsvc_nginx_public"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_ftask_nginx.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.public_subnet.id]  # Replace with your public subnet ID(s)
    security_groups = [aws_security_group.allow_http_sg.id]  # Replace with your security group ID
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = {
    Name = "ecs_fsvc_nginx_public"
  }
}

resource "aws_ecs_service" "ecs_fsvc_nginx_private" {
  name            = "ecs_fsvc_nginx_private"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_ftask_nginx.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.private_subnet.id]  # Replace with your public subnet ID(s)
    security_groups = [aws_security_group.allow_http_sg.id]  # Replace with your security group ID
    assign_public_ip = false
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = {
    Name = "ecs_fsvc_nginx_private"
  }
}