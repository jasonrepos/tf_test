provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_cluster" "nginx_cluster" {
  name = "${var.environment}-cluster"
}

resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu           = "256"
  memory        = "512"
  task_role_arn = aws_iam_role.ecs_task_role.arn

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "nginx-container"
    image = "nginx:latest"
    portMappings = [{
      containerPort = 80,
      hostPort      = 80,
    }]
  }])
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "nginx_service" {
  name            = "${var.environment}-${var.service}"
  cluster         = aws_ecs_cluster.nginx_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [module.vpc.subnet_ids["web-1"]]
    security_groups = [module.vpc.security_group_ids["ecs"]]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx_target_group.arn
    container_name   = "nginx-container"
    container_port   = 80
  }

  depends_on = [aws_ecs_task_definition.nginx_task]
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  engine                 = "postgres"
  engine_version         = "13.23"
  instance_class         = "db.t3.micro"
  multi_az               = true
  db_name                = "mydb"
  username               = var.rds_username
  password               = random_password.rds_password.result
  skip_final_snapshot    = true
  vpc_security_group_ids = [module.vpc.security_group_ids["database"]]
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "main"
  subnet_ids = [module.vpc.subnet_ids["public-1"], module.vpc.subnet_ids["public-2"]]
}
