module "ecs" {
  source = "./modules/ecs"

  environment    = var.environment
  service        = var.service
  container_image = var.container_image
  container_port  = var.container_port
  cpu             = var.cpu
  memory          = var.memory
  desired_count   = var.desired_count

  subnet_ids         = [module.vpc.subnet_ids["web-1"]]
  security_group_ids = [module.vpc.security_group_ids["ecs"]]
  target_group_arn   = aws_lb_target_group.nginx_target_group.arn
}
